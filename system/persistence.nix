{ lib, config, pkgs, ... }:
{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/flatpak"
      "/var/lib/systemd/coredump"
      "/var/lib/nixos"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # machine-id is used by systemd for the journal, if you don't persist this
      # file you won't be able to easily use journalctl to look at journals for
      # previous boots.
      "/etc/machine-id"
    ];
    users.crimson = {
      directories = [
        ".local/share/nvim"
        ".local/share/Trash"
        ".local/share/gnome-builder"
        ".local/share/flatpak"
        ".local/share/gnome-shell/extensions/"
        ".config/VSCodium"
        ".config/zsh/"
        ".mozilla/firefox"
        ".vscode-oss"
        ".emacs.d"
        ".ssh"
        "Downloads"
        "Documents"
        "dotfiles"
        "Pictures"
        "Music"
        "Videos"
        "Templates"
      ];
      files = [
        ".zsh_history"
      ];
    };
  };
}

