dotfiles
========

## NixOS installation

### Prepare Drive

1. Current partition scheme is an EFI partition of 512MiB with boot, ESP flags turned on. Easy with Gparted GUI program.
2. Turn EFI partition as boot with `set <partition number> boot on` on the parted prompt.
3. Swap as same size as RAM. Enable swap after partion creation with `sudo swapon /dev/nvme0n1p<n>`
4. Rest as nix parition with `sudo parted /dev/nveme0n1 --script mkpart nix <starting part in GB> <ending part in GB>`, find the starting and end with `sudo parted /dev/nvme0n1 print`.
5. Check alignment with `for i in {1..<n>}; do sudo parted /dev/nvme0n1 -- align-check optimal $i; done`.

### Encrypt nix drive

1. Format for LUKS with `sudo cryptsetup luksFormat /dev/nvme0n1p<n>`.
2. Enter passphrase when prompted.
3. Open the nix drive with `sudo cryptsetup luksOpen /dev/nvme0n1p<n> crypted` at `/dev/mapper/crypted`.
4. Format the encrypted partition with ext4 with the command `sudo mkfs.ext4 -L nix /dev/mapper/crypted`.
5. Verify drives scheme with `sudo parted /dev/nvme0n1 -- unit MiB print`.
6. Should look like the following:

```markdown
| Number | Size  | File system    | Name | Flags     |
| ------ | ----- | -------------- | ---- | --------- |
| 1      | 512MB | fat32          | EFI  | boot, esp |
| 2      | 16GB  | linux-swap(v1) | swap | swap      |
| 3      | <n>   | ext4           | nix  |           |
```

### Mount drives

1. Mount tmpfs at `/mnt` with `sudo mount -v -t tmpfs none /mnt`.
2. Create directories to mount to with `sudo mkdir -v -p /mnt/{boot,nix,etc/nixos,home/crimson/dotfiles,var/log}`
3. Mount `/boot` to `/mnt/boot` with `sudo mount -v /dev/nvme0n1p<n> /mnt/boot -o umask=0077`
4. Mount encrypted drive to `/mnt/nix` with `sudo mount -v /dev/mapper/crypted /mnt/nix`
5. Create persistent directories with `sudo mkdir -v -p /mnt/nix/persist/{etc/nixos,home/crimson/dotfiles,var/log}`.
6. Bind mount config and logs with `sudo mount -v -o /mnt/nix/persist/etc/nixos /mnt/etc/nixos` & `sudo mount -v -o bind /mnt/nix/persist/var/log /mnt/var/log`.

### Generate hardware configuration

1. To get `hardware-configuration.nix` run the command `sudo nixos-generate-config --root /mnt`
2. Change directory to config with `cd mnt/etc/nixos`.
3. Ignore error of Not Btrfs filesystem.

### Edit hardware-configuration.nix

1. Edit to add options in tmpfs section with `sed -i '/fsType = "tmpfs";/a options = [ "defaults" "size=25%" "mode=755" ];' ./hardware-configuration.nix` or manually.

```diff
{
#------------------
  fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
+     options = [ "defaults" "size=25%" "mode=755" ];
  };
#----------------
}
```

2. Fix [this error](https://github.com/NixOS/nixpkgs/issues/279362) with `sed -i '/fsType = "vfat"/a options = [ "umask=0077" ];' ./hardware-configuration.nix` or manually. `sed` command adds `options = [ "umask=0077"];` on the vfat section.

```diff
{
#------------------
      fsType = "vfat";
+     options = [ "umask=0077" ];
#----------------
}
```

### Encrypt Swap

1. The `by-uuid` generated for the `swapDevice` in the `hardware-configuration.nix` needs to change to the `by-partuuid` because when using the `randomEncryption.enable = true` the `by-uuid` changes every boot.
2. Get `by-uuid` & `by-partuuid` with `ls -l /dev/disk/by-uuid` & `ls -l /dev/disk/by-partuuid` respectively. Take values of the swap partition.
3. Swap out `by-uuid/<by-uuid number>` with `by-partuuid/<by-partuuid number` (there should only be one occurance of such but if multiple exists swap for all) followed by `randomEncryption.enable = true;` on new line below.

### Get config from git

1. Setup network.

```txt
Configure WPA supplicant so we can use WIFI:

$ cat > /etc/wpa_supplicant.conf
network={
  ssid="****"
  psk="****"
}
^D
$ systemctl start wpa_supplicant
```

2. Clone repo `git clone https://github.com/sudanchapagain/dotfiles.git`
3. Swap out the repo's hardware config with newly generated one.
4. (optional) Move the config to `/mnt/nix/persist/home/crimson/dotfiles/`.
5. Add current hardware config to git with `git add .` because nix expects everything to be touched by git.

### Install

1. cd to whichever directory the config is on.
2. run `sudo nixos-install --flake .#crimson --no-root-passwd`
3. Reboot system.

### Additional notes

1. Error on logout is [this](https://github.com/nix-community/impermanence/issues/21) which is harmless AFAIK.
2. Troubleshooting: If for whatever reason the system doesn't boot, we can go back to the installation environment by booting from the ISO and remounting all partitions with `cryptsetup luksOpen /dev/nvme0n1p<n> crypted` and mount tmpfs to /mnt and etc (see above config).
3. Currently boot order set from UEFI determines the OS that's booted into however for dualboot or more OS a rEFInd as boot option is easiest option. Link to current rEFInd theme/config [github/sudanchapagain/rEFInd-theme](https://github.com/sudanchapagain/rEFInd-theme)

### Resources

- [nixos/learn](https://nixos.org/learn)
- [nix.dev](https://nix.dev/)
- [zero-to-nix.com](https://zero-to-nix.com/)
- ["Impermanent NixOS: on a VM + tmpfs root + flakes + LUKS" by will bush (blog)](https://willbush.dev/blog/impermanent-nixos/): tmpfs
- ["NixOS ❄: tmpfs as root" by elis](https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/): tmpfs
- ["Paranoid NixOS Setup" by xe](https://xeiaso.net/blog/paranoid-nixos-2021-07-18/): contains additional config for networks and etc.

### Additional Resources

uses different filesystems and things but generally similar.

- ["Erase your darlings: immutable infrastructure for mutable systems" by Graham Christensen](https://grahamc.com/blog/erase-your-darlings/): uses ZFS
- ["NixOS as a server, part 1: Impermanence" by guekks](https://guekka.github.io/nixos-server-1/): uses btrfs

### Credits

I do not remember all of places where i have taken the config snippets and this README text (many gists, blogs, and other's configs) but i used will bush's blog as primary resource.
