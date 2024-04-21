{ lib, config, pkgs, ...}:
{
    services.xserver.libinput = {
      enable = true;
      mouse = {
        accelProfile = "adaptive";
        accelSpeed = "-0.5";
        scrollMethod = "twofinger";
      };

    touchpad = {
       accelProfile = "adaptive";
       accelSpeed = "-0.5";
       scrollMethod = "twofinger";
       tapping = true;
       disableWhileTyping = true;
    };
  };
}