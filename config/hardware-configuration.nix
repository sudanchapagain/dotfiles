{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # fileSystems."/" =
  #   {
  #     device = "none";
  #     fsType = "tmpfs";
  #     options = [ "defaults" "size=25%" "mode=755" ];
  #   };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/63B9-913B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3f89ca47-aa9f-4eaa-a504-80110c8afdcf";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."luks-db8cfe31-000a-48b4-a15f-0323d8a55f0d".device = "/dev/disk/by-uuid/db8cfe31-000a-48b4-a15f-0323d8a55f0d";

  # fileSystems."/etc/nixos" =
  #   {
  #     device = "/nix/persist/etc/nixos";
  #     fsType = "none";
  #     options = [ "bind" ];
  #   };

  # fileSystems."/var/log" =
  #   {
  #     device = "/nix/persist/var/log";
  #     fsType = "none";
  #     options = [ "bind" ];
  #   };

  swapDevices = [{
    device = "/swapfile";
    randomEncryption.enable = true;
  }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
