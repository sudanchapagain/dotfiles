{ pkgs, ... }:

{
    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };

    zramSwap = {
        enable = true;
        memoryPercent = 100;
        priority = 100;
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

    powerManagement = {
        enable = true;
        cpuFreqGovernor = "balanced";
    };

    networking = {
        hostName = "crimson";
        networkmanager = {
            enable = true;
        };
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

    services = {
        resolved = {
            enable = true;
            settings = {
                Resolve = {
                    dnsovertls = [
                        "9.9.9.9"
                        "149.112.112.112"
                    ];
                    fallbackDns = [ "1.1.1.1" ];
                };
            };
        };

        logind = {
            settings = {
                Login = {
                    extraConfig = "HibernateDelaySec=30min";
                    HandlePowerKey = "suspend-then-hibernate";
                    HandlePowerKeyLongPress = "poweroff";
                    HandleLidSwitch = "suspend-then-hibernate";
                    HandleLidSwitchExternalPower = "suspend-then-hibernate";
                    HandleLidSwitchDocked = "suspend-then-hibernate";
                    HoldoffTimeoutSec = "5s";
                    IdleAction = "suspend-then-hibernate";
                    IdleActionSec = "300s";
                };
            };
        };
        flatpak.enable = true;

        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
        dbus.enable = true;
        gvfs.enable = true;
        devmon.enable = true; # monitors for new storage devices
        udisks2.enable = true; # allows apps like Nautilus to query and manipulate storage devices
        blueman.enable = true; # GUI Bluetooth manager
        fstrim = {
            enable = true;
            interval = "monthly";
        }; # Trim SSD in the background, once every month.

        postgresql = {
            enable = true;
            authentication = pkgs.lib.mkOverride 10 ''
                #type database DBuser origin-address auth-method
                local all      all     trust
                # ... other auth rules ...

                # ipv4
                host  all      all     127.0.0.1/32   trust
                # ipv6
                host  all      all     ::1/128        trust
            '';
        };

        mpd = {
            enable = true;
            startWhenNeeded = true;
            openFirewall = true;

            settings = {
                music_directory = "/home/crimson/Music";

                port = 6600;

                metadata_to_use = "artist,album,title,track,name,genre,date,composer,performer,disc";

                input = [ { plugin = "curl"; } ];

                audio_output = [
                    {
                        type = "pulse";
                        name = "Pulse Output";
                    }
                ];

                save_absolute_paths_in_playlists = "no";
                auto_update = "yes";
                auto_update_depth = "10";
            };
        };

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        # To disable installing GNOME's suite of applications
        # and only be left with GNOME shell.
        gnome = {
            core-apps.enable = true;
            core-developer-tools.enable = false;
            games.enable = false;

            gnome-browser-connector.enable = false;
            gnome-initial-setup.enable = false;
            # gnome-online-accounts.enable = false;
            gnome-remote-desktop.enable = false;

            gnome-keyring.enable = true;
            sushi.enable = true;
        };
    };

    environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-logs
        gnome-weather
        gnome-maps
        gnome-contacts
        gnome-user-docs
        gnome-music
        decibels
        epiphany
        simple-scan
        yelp
        geary
        orca
        gnome-shell-extensions
        gnome-themes-extra
        gnome-system-monitor
        gnome-connections
        gnome-console
    ];
}
