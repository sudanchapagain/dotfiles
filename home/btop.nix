{ config, pkgs, ... }:
{
  xdg.configFile."btop/themes/mellow.theme".text = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "sudanchapagain";
      repo = "mellow-btop";
      rev = "01fa19355b6b1a41f6c354352eebd376674bdbcb";
      sha256 = "sha256-O1Em+joLriYa6tJdp4Jk5bb8voNroFgD8SBYJ8jLmwg=";
    }
    + "/mellow-invisible.theme"
  );

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "mellow";
      vim_keys = true;
      rounded_corners = true;
    };
  };
}