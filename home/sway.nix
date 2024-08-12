{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "ulauncher";
      startup = [{ command = "swaybg -i $HOME/dotfiles/wallpaper/grass.jpg"; }];
      bars = [{ command = "waybar"; }];

      fonts = {
        names = [ "Inter" "JetBrains Mono" "FontAwesome5Free" ];
        style = "Regular";
        size = 12.0;
      };

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
        border = 2;
      };
      floating = {
        titlebar = false;
        border = 0;
      };

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        outer = 1;
        inner = 4;
      };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          tap_button_map = "lrm";
          natural_scroll = "enabled";
          dwt = "enabled";
          middle_emulation = "enabled";
          scroll_method = "two_finger";
          pointer_accel = "0";
        };
      };

      keybindings = {
        "Mod4+Return" = "exec ${terminal}";
        "Mod4+F" = "exec firefox";
        "Mod4+s" = "exec grim";
        "Mod4+Shift+q" = "kill";
        "Mod4+d" = "exec ${menu}";
        "Mod4+Shift+e" = "exec swaymsg exit";
        #"Mod4+space" = "exec ${menu}";
        "Mod4+C" = "exec codium . --ozone-platform=wayland";
        "Mod4+Shift+R" = "reload";
        "Mod4+Shift+S" = "grim -g '$(slurp)'";

        # WINDOW STUFF
        "Mod4+Shift+space" = "floating toggle";
        "Mod4+Shift+F" = "fullscreen toggle";
        "Mod4+Left" = "focus left";
        "Mod4+Down" = "focus down";
        "Mod4+Up" = "focus up";
        "Mod4+Right" = "focus right";
        "Mod4+b" = "splith";
        "Mod4+v" = "splitv";

        "Mod4+Ctrl+Right" = "resize shrink width 3 px or 3 ppt";
        "Mod4+Ctrl+Down" = "resize grow height 3 px or 3 ppt";
        "Mod4+Ctrl+Up" = "resize shrink height 3 px or 3 ppt";
        "Mod4+Ctrl+Left" = "resize grow width 3 px or 3 ppt";

        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+Down" = "move down";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+Right" = "move right";

        # WORKSPACES
        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";

        # MOVE WINDOW
        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";

        # Audio
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +2%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -2%";
        "XF86AudioMute" = "exec set-volume toggle-mute";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

        "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 2%+";
      };
    };

    extraConfig = ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };
}
