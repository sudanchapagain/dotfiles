{ ... }:

{
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

        mpd = {
            enable = true;
            startWhenNeeded = true;
            network.listenAddress = "any";

            extraConfig = ''
                music_directory "~/Music"
                playlist_directory "~/.config/mpd/playlists"

                db_file "~/.config/mpd/database"
                log_file "~/.config/mpd/log"
                pid_file "~/.config/mpd/pid"
                state_file "~/.config/mpd/state"
                sticker_file "~/.config/mpd/sticker.sql"

                bind_to_address "127.0.0.1"
                port "6600"

                metadata_to_use "artist,album,title,track,name,genre,date,composer,performer,disc"

                input {
                    plugin "curl"
                }

                audio_output {
                    type "pulse"
                    name "Pulse Output"
                }

                save_absolute_paths_in_playlists "no"
                auto_update "yes"
                auto_update_depth "3"
            '';
        };
    };
}
