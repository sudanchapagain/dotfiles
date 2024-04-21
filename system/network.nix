{ lib, config, pkgs, ...}:
{
    networking = {
    hostName = "crimson";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall = {
      enable = false;
      #allowedTCPPorts = [ 59010 59011 ];
      #allowedUDPPorts = [ 59010 59011 ];
    };
  };
}