{ lib, config, pkgs, ...}:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          # Battery info for Bluetooth devices
          Experimental = true;
        };
      };
    };

    # Hardware acceleration.
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
}