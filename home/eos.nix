{ lib, config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/crimson/dotfiles/wallpaper/ring.jpg";
      picture-uri-dark = "file:///home/crimson/dotfiles/wallpaper/grass.jpg";
    };
    "org/gnome/desktop/session" = {
      idle-delay = "uint32 18";
    };
    "org/gnome/system/location" = {
      enabled = false;
    };
    "io/elementary/desktop/agent-geoclue2" = {
      location-enabled = false;
    };
    "org/pantheon/desktop/gala/mask-corners" = {
      corner-radius = 16;
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
      show-full-name-in-top-bar = false;
    };
    "org/gnome/desktop/thumbnail-cache" = {
      maximum-age = 1;
    };
    "net/launchpad/plank/docks/dock1/dock-items" = {
      dock-items = ["
                      'io.elementary.switchboard.dockitem',
                      'io.elementary.appcenter.dockitem'
                    "];
    };
    "org/gnome/desktop/privacy" = {
      remeber-recent-files = false;
      remember-app-usage = false;
      usb-protection = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-battery-timeout = 30;
      sleep-inactive-ac-timeout = 30;
    };
    "io/elementary/desktop/wingpanel/bluetooth" = {
      bluetooth-enabled = false;
    };
    "io/elementary/desktop/wingpanel/power" = {
      show-percentage = true;
    };
    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
    };
    "net/launchpad/plank/docks/dock1" = {
      pressure-reveal = true;
    };
    "org/pantheon/desktop/gala/behavior" = {
      hotcorner-topleft = "open-launcher";
    };
    "org/gnome/desktop/interface" = {
      document-font-name = "Inter Variable 11";
      font-name = "Inter Variable 11";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
      titlebar-font = "Inter Variable Bold 11";
      text-scaling-factor = 1;
      clock-format = "12h";
      gtk-theme = "io.elementary.stylesheet.strawberry";
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-center = [ "<Super>c" ];

      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
      move-to-workspace-10 = [ "<Super><Shift>0" ];

      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      switch-to-workspace-10 = [ "<Super>0" ];
    };
  };
}
