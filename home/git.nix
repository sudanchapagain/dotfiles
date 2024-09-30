{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Sudan Chapagain";
    userEmail = "101015050+sudanchapagain@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = true;
      core.editor = "hx";
      credential.helper = "store";
      github.user = "sudanchapagain";
      gpg.format = "ssh";
    };
    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
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
