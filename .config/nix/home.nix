{ inputs, outputs, lib, home-manager, config, pkgs, ... }:

{
  home.username = "crimson";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/crimson";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };
  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };


  home.packages = with pkgs; [
    neofetch
    yazi

    ripgrep
    jq
    eza
    fzf

    which
    tree

    # nix related
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    glow
    btop

  ];

  programs.starship = {
    enable = true;
    # # custom settings
    #settings = {
    # add_newline = false;
    #aws.disabled = true;
    #      gcloud.disabled = true;
    #     line_break.disabled = true;
    #  };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";

      window = {
        padding.x = 5;
        padding.y = 5;
        dimensions.lines = 50;
        dimensions.columns = 200;
        decoration = "full";
        dynamic_title = true;
        opacity = 0.95;
        blur = true;
        decorations_theme_variant = "Dark";
      };

      cursor = {
        style = {
          shape = "Bean";
          blinking = "On";
        };
      };
      live_config_reload = true;

      font = {
        size = 14;
        normal.family = "JetBrainsMono Nerd Font";
        bold.family = "JetBrainsMono Nerd Font";
        italic.family = "JetBrainsMono Nerd Font";
        bold_italic.family = "JetBrainsMono Nerd Font";
      };

      scrolling = {
        multiplier = 5;
        history = 10000;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          foreground = "#e0def4";
          background = "#191724";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };

        vi_mode_cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };

        search.matches = {
          foreground = "#908caa";
          background = "#26233a";
        };

        search.focused_match = {
          foreground = "#191724";
          background = "#ebbcba";
        };

        hints.start = {
          foreground = "#908caa";
          background = "#1f1d2e";
        };

        hints.end = {
          foreground = "#6e6a86";
          background = "#1f1d2e";
        };

        line_indicator = {
          foreground = "None";
          background = "None";
        };

        footer_bar = {
          foreground = "#e0def4";
          background = "#1f1d2e";
        };


        selection = {
          text = "#e0def4";
          background = "#403d52";
        };

        normal = {
          black = "#26233a";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };

        bright = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };

        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    #   bashrcExtra = ''
    #    export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    # '';

    shellAliases = {
      # k = "kubectl";
    };
  };

}
