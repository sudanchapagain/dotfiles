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
      ls = "eza -g --icons --hyperlink";
      ll = "eza -lg --icons --hyperlink";
      l = "eza -lga --icons --hyperlink";
      sysbuild = "sudo nixos-rebuild switch --flake ~/dotfiles/";
      sbuild = "sudo nixos-rebuild switch --flake ~/dotfiles/ --specialisation eos";
    };
    bashrcExtra =
      #Start tmux and starship
      ''
        eval "$(starship init bash)"
      '';
  };
}
