{ lib, config, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    gnome = {
      core-developer-tools.enable = false; # enables builder, sysprof etc.
      # False because builder is broken somehow, install builder from flatpak
      # flatpak install flathub org.gnome.Builder
      # flatpak install flathub re.sonny.Workbench
      gnome-keyring.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ ];
  };

  services = {
    flatpak.enable = true;
    printing.enable = false;
    #openssh.enable = true;
    dbus.enable = true;
    gvfs.enable = true;
    devmon.enable = true; # monitors for new storage devices
    udisks2.enable = true; #allows apps like Nautilus to query and manipulate storage devices
    blueman.enable = true; # GUI Bluetooth manager
    fstrim = { enable = true; interval = "monthly"; }; # Trim SSD in the background, once every month.
    logind.extraConfig = ''HandlePowerKey=suspend'';
  };
}
