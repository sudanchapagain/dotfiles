{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "full";
        dynamic_padding = true;
        dimensions = { columns = 200; lines = 50; };
        padding = { x = 10; y = 10; };
        opacity = 1;
        #blur = true;
        dynamic_title = true;
        decorations_theme_variant = "Dark";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        normal.style = "Regular";
        bold.family = "JetBrainsMono Nerd Font";
        bold.style = "Bold";
        italic.family = "JetBrainsMono Nerd Font";
        italic.style = "Italic";
        bold_italic.family = "JetBrainsMono Nerd Font";
        bold_italic.style = "Bold Italic";
      };

      colors = {
        draw_bold_text_with_bright_colors = true;

        primary = {
          foreground = "#c9c7cd";
          background = "#161617";
        };

        cursor = {
          text = "#757581";
          cursor = "#c9c7cd";
        };

        normal = {
          black = "#27272a";
          red = "#f5a191";
          green = "#90b99f";
          yellow = "#e6b99d";
          blue = "#aca1cf";
          magenta = "#e29eca";
          cyan = "#ea83a5";
          white = "#c1c0d4";
        };

        bright = {
          black = "#353539";
          red = "#ffae9f";
          green = "#9dc6ac";
          yellow = "#f0c5a9";
          blue = "#b9aeda";
          magenta = "#ecaad6";
          cyan = "#f591b2";
          white = "#cac9dd";
        };
      };
    };
  };
}
