{ pkgs, ... }:

{
    services = {
        logind = {
            settings = {
                Login = {
                    HandleLidSwitchDocked = "suspend";
                    HandleLidSwitchExternalPower = "suspend";
                    HandleLidSwitch = "suspend";
                };
            };
        };

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        # To disable installing GNOME's suite of applications
        # and only be left with GNOME shell.
        gnome.core-apps.enable = true;
        gnome.core-developer-tools.enable = true;
        gnome.games.enable = false;


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
        gnome.gnome-keyring.enable = true;
        devmon.enable = true; # monitors for new storage devices
        udisks2.enable = true; # allows apps like Nautilus to query and manipulate storage devices
        blueman.enable = true; # GUI Bluetooth manager
        fstrim = {
            enable = true;
            interval = "monthly";
        }; # Trim SSD in the background, once every month.
        logind.settings.Login = {
            HandlePowerKey = "suspend";
        };

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
    };
}
