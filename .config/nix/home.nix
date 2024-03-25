{ inputs, outputs, lib, config, pkgs, ... }:

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

   programs.git = {
     enable = true;
     userName = "Sudan Chapagain";
     userEmail = "101015050+sudanchapagain@users.noreply.github.com";
   };

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
        padding.x = ;
        padding.y = ;
        decoration = "";
        startup_mode = "";
        dynamic_title = true;
        opacity = ;
      };

      cursor = {
        style = {
          shape = "Bean";
          blinking = "On"
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
