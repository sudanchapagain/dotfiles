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

