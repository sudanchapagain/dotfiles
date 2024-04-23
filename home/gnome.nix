{ lib, config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [ ];
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];
   };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = ["<>"];
      switch-to-application-2 = ["<>"];
      switch-to-application-3 = ["<>"];
      switch-to-application-4 = ["<>"];
      switch-to-application-5 = ["<>"];
      switch-to-application-6 = ["<>"];
      switch-to-application-7 = ["<>"];
      switch-to-application-8 = ["<>"];
      switch-to-application-9 = ["<>"];
    };
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.75;
      noise-amount = 0;
      noise-lightness = 0;
      sigma = 30;       
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
      show-hidden = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/crimson/dotfiles/wallpaper/ring.jpg";
      picture-uri-dark = "file:///home/crimson/dotfiles/wallpaper/grass.jpg";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = "uint32 300";
    };
    "org/gnome/desktop/interface" = {
      document-font-name = "Inter Variable 11";
      font-name = "Inter Variable 11";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
      titlebar-font = "Inter Variable Bold 11";
      text-scaling-factor = "0.95";
      clock-format = "12h";
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-center = ["<Super>c"];

      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];

      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
  };
}
