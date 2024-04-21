{ config, pkgs, ... }:

{
  xdg.configFile."btop/themes/rose-pine.theme".text =
    builtins.readFile (pkgs.fetchFromGitHub
      {
        owner = "rose-pine";
        repo = "btop";
        rev = "6d6abdc0a8c8bcd3b056d9fe3256cfbe7e359312";
        sha256 = "sha256-sShQYfsyR5mq/e+pjeIsFzVZv3tCpQEdGC9bnTKlQ5c=";
      } + "/rose-pine.theme");

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "rose-pine";
      vim_keys = true;
      rounded_corners = true;
    };
  };
}
