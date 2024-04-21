{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "erasedups" ];
    historyIgnore = [ "ls" "ll" "l" "cd" "exit" "eza" "neofetch" ];
    shellOptions = [ "checkwinsize" ];
    shellAliases = {
      code = "codium $@";
      ls = "eza -g --icons";
      ll = "eza -lg --icons";
      l = "eza -lga --icons";
      sysbuild = "sudo nixos-rebuild switch --flake ~/dotfiles/";
    };
    bashrcExtra =
      #Start tmux and starship
      ''
        eval "$(starship init bash)"
      '';
  };
}
