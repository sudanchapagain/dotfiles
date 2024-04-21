{ lib, config, pkgs, ...}:
{
    environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
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
        ".mozilla/firefox"
        ".local/share/nvim"
        ".local/share/Trash"
        ".config/VSCodium"
        ".vscode-oss"
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
        ".bash_history"
        ".zsh_history"
      ];
    };
  };
}