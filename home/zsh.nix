{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 5000;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignorePatterns = [ "rm *" "ls" "l" "ll" "exit" ];
      ignoreSpace = true;

    };
    shellAliases = {
      pretty = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ls = "eza -g --icons --hyperlink";
      ll = "eza -lg --icons --hyperlink";
      l = "eza -lga --icons --hyperlink";
      c = "clear";
      sysbuild = "sudo nixos-rebuild switch --flake ~/dotfiles/";
      sbuild = "sudo nixos-rebuild switch --flake ~/dotfiles/ --specialisation eos";
    };

    #    initExtraFirst = ''eval "$(oh-my-posh prompt init zsh --config $HOME/.config/ohmyposh/config.toml"'';

    initExtra = ''
      bindkey -v
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      eval "$(fzf --zsh)"

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    '';
  };

  programs.starship = {
    enable = true;
  };
}
