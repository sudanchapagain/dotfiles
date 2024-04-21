{ lib, home-manager, hyprland, impermanence, hyprlock, hypridle, hyprland-contrib, lanzaboote, rose-pine-hyprcursor, config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      general = {
        gaps_in = 4;
        gaps_out = 0;
        border_size = 0;
        "col.active_border" = "rgba(33ccffee)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape,escape:caps";
        kb_rules = "";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.3;
          disable_while_typing = true;
        };

        repeat_rate = 40;
        repeat_delay = 250;
        force_no_accel = true;
        sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification.
        follow_mouse = 1;
        numlock_by_default = false;
      };

      misc = {
        disable_hyprland_logo = true;
        vfr = true;
        disable_autoreload = true; # useless cause nixos
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 5;
          passes = 5;
          new_optimizations = true;
          xray = true;
        };

        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        active_opacity = 1;
        inactive_opacity = 1;
        fullscreen_opacity = 1;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%"
          "windowsOut, 1, 3, fluent_decel, popin 70%"
          "windowsMove, 1, 2, easeinoutsine, slide"
          # Fade
          "fadeIn, 1, 3, easeOutCubic"
          "fadeOut, 1, 1.7, easeOutCubic"
          "fadeSwitch, 0, 1, easeOutCirc"
          "fadeShadow, 1, 10, easeOutCirc"
          "fadeDim, 1, 4, fluent_decel"
          "border, 1, 2.7, easeOutCirc"
          "borderangle, 1, 30, fluent_decel, once"
          "workspaces, 1, 3, easeOutCubic, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_is_master = true;

      gestures = {
        workspace_swipe = "on";
        workspace_swipe_distance = 100;
      };

      "$mainMod" = "SUPER";

      bind = [
        ", F11, fullscreen"
        "$mainMod, c, killactive,"
        "$mainMod SHIFT, m, exit,"
        "$mainMod, t, togglefloating,"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle
        "$mainMod, L, exec, ~/.config/scripts/lock.sh"
        "$mainMod, v, exec, ${pkgs.emote}/bin/emote"
        "$mainMod, q, exec, ${pkgs.alacritty}/bin/alacritty"
        "$mainMod, e, exec, ${pkgs.gnome.nautilus}/bin/nautilus"
        "$mainMod, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
        #", Print, exec, ${pkgs.grimblast}/bin/grimblast --notify --cursor copysave area ~/Pictures/Screenshots/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        #"SHIFT, Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copysave screen ~/Pictures/Screenshots/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Tab through
        "$mainMod, TAB, workspace, e+1"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        # Resize active window
        "SHIFT, right, resizeactive, 20 0"
        "SHIFT, left, resizeactive, -20 0"
        "SHIFT, up, resizeactive, 0 -20"
        "SHIFT, down, resizeactive, 0 20"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        #"${pkgs.polkit-agent-helper-1}/bin/polkit-agent-helper-1"
        "systemctl start --user "
        "${pkgs.hyprpaper}/bin/hyprpaper"
        #"${pkgs.hypridle}/bin/hypridle"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.dunst}/bin/dunst"
      ];

    };
  };
}
