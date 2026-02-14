{ pkgs, ... }:

{
    programs.kdeconnect = {
        enable = true;
        package = pkgs.valent;
    };

    services = {
        desktopManager.gnome.enable = true;
        displayManager.gdm = {
            enable = true;
            wayland = true;
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

        postgresql.enable = true;
        mpd = {
            enable = true;
            startWhenNeeded = true;
            openFirewall = true;

            settings = {
                music_directory = "/home/crimson/Music";
                playlist_directory = "/home/crimson/.config/mpd/playlists";

                db_file = "/home/crimson/.config/mpd/database";
                log_file = "/home/crimson/.config/mpd/log";
                pid_file = "/home/crimson/.config/mpd/pid";
                state_file = "/home/crimson/.config/mpd/state";
                sticker_file = "/home/crimson/.config/mpd/sticker.sql";

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
                auto_update_depth = "3";
            };
        };
    };
}
