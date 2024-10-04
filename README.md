<div align="center">
  <h1>dotfiles</h1>
  <p>dotfiles for alacritty, tmux, starship, helix, etc.</p>
</div>

> [!IMPORTANT]
> this is for my use only. It's public so that i can clone it without having to login to github. I wrote this README to quickly get back to a minimally similar state of the machine.

### Partitioning

**Partitions**: Four partitions: one for `/home`, and one for `/` both using Btrfs, then one for `/efi` and `swap`. (consider having swap or no swap)

### System Configuration

Follow GUI wizard then change the following settings after installation. Adjust text size in desktop settings to **1.10**. Disable browser history and location services. Set the time format to **AM/PM**. Disable automatic time setting and select **Asia/Kathmandu** as timezone.

### Package Management

**Update Packages**: `sudo apt update && sudo apt upgrade` 

**Get this repo**: `sudo apt install git` or directly download the zip via default browser. Clone it and remove git with `sudo apt remove git` (remove because home-manager has a entry for git)

**Install Nix**: `sh <(curl -L https://nixos.org/nix/install) --daemon` [AFAIK CURL doesn't exit by default either install it or visit the script page copy paste into a file and run that file. This will take a while till then trigger updating in appcenter. Restart machine and try again to see updates. Sometimes there is additional updates. Complete that update too then finally run home-manager.

**Home Manager Setup**: `nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager` then `nix-channel --update` then `nix-shell '<home-manager>' -A install` and finally `home-manager switch --flake . --extra-experimental-features nix-command --extra-experimental-features flakes`
