{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Sudan Chapagain";
    userEmail = "101015050+sudanchapagain@users.noreply.github.com";
#    TODO : git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = true;
      core.editor = "neovim";
      credential.helper = "store";
      github.user = "sudanchapagain";
    };
    ignores = [
      ".cache/"
      ".idea/"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
      "target/"
    ];
  };
}
