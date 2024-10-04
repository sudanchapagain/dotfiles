<div align="center">
  <h1>dotfiles</h1>
  <p>dotfiles for alacritty, tmux, starship, helix, etc.</p>
</div>

> [!IMPORTANT]
> this is for my use only. It's public so that i can clone it without having to login to github. I wrote this README to quickly get back to a minimally similar state of the machine.

### Partitioning

**Partitions**:

- `/home` *btrfs*
- `/` *btrfs*
- `/efi`
- `swap`

### System Configuration

- Follow GUI wizard.

After installation

- Adjust text size in desktop settings to **1.10**.
- Disable browser history and location services.
- Set the time format to **AM/PM**.
- Disable automatic time setting and select **Asia/Kathmandu** as timezone.

### Package Management

**Update Packages**:

`sudo apt update && sudo apt upgrade` 

**Get this repo**: either install git or download the repo as a zip.

**Install Nix**:

- `sh <(curl -L https://nixos.org/nix/install) --daemon` *[AFAIK CURL doesn't exit by default either install it or visit the script page copy paste into a file and run that file]*.
- This will take a while till then trigger updates in appcenter.
- Restart machine and try again to see updates. *Sometimes there is additional updates so don't skip*.

**Home Manager Setup**: 

- `nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager`
- `nix-channel --update`
- `nix-shell '<home-manager>' -A install`
- `home-manager switch --flake . --extra-experimental-features nix-command --extra-experimental-features flakes`
