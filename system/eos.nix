{ lib, config, pkgs, ... }:
{
  specialisation.eos.configuration = {
    services.xserver = {
      displayManager = {
        gdm.enable = lib.mkForce false;
        lightdm.enable = true;
      };
      desktopManager = {
        gnome.enable = lib.mkForce false;
        pantheon = {
          enable = true;
          extraWingpanelIndicators = with pkgs; [ wingpanel-indicator-ayatana ];
          extraSwitchboardPlugs = [ ];
        };
      };
    };
  };

}
