{ lib, config, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      desktopManager.pantheon = {
        enable = true;
        extraWingpanelIndicators = with pkgs; [ wingpanel-indicator-ayatana ];
        extraSwitchboardPlugs = [ ];
      };
      displayManager.lightdm.enable = true;
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
