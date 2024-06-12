{ config, pkgs, ... }:
{
  fonts = {
    enableGhostscriptFonts = true;
    packages = with pkgs;[
      corefonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      #font-awesome
      #liberation_ttf
      inter
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        monospace = [ "JetBrainsMono" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
