{ lib, config, pkgs, ...}:
{
  time = {
    timeZone = "Asia/Kathmandu";
    hardwareClockInLocalTime = true;
  };
  
  i18n.defaultLocale = "en_US.UTF-8";

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
}