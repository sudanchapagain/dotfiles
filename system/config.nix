{ config, pkgs, ... }:

{
    # Set your time zone.
    time = {
        timeZone = "Asia/Kathmandu";
        hardwareClockInLocalTime = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    powerManagement = {
        enable = true;
        cpuFreqGovernor = "balanced";
    };

    networking = {
        hostName = "crimson";
        networkmanager.enable = true;
        # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
        # Configure network proxy if necessary
        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        enableIPv6 = false;
        firewall = {
            enable = true;
            # allowedTCPPorts = [ 59010 59011 ];
            # allowedUDPPorts = [ 59010 59011 ];
        };
    };

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ ];
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };

    zramSwap = {
        enable = true;
        algorithm = "lz4";
    };

    hardware = {
        bluetooth = {
            enable = true;
            powerOnBoot = false;
        };

        # Hardware acceleration.
        graphics = {
            enable = true;
            extraPackages = with pkgs; [
                intel-media-driver
                libvdpau-va-gl
            ];
        };
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
    };

    systemd = {
        user = {
            #startServices = "sd-switch";
            services.polkit-gnome-authentication-agent-1 = {
                description = "polkit-gnome-authentication-agent-1";
                wantedBy = [ "graphical-session.target" ];
                wants = [ "graphical-session.target" ];
                after = [ "graphical-session.target" ];
                serviceConfig = {
                    Type = "simple";
                    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                    Restart = "on-failure";
                    RestartSec = 1;
                    TimeoutStopSec = 10;
                };
            };
        };
    };
}
