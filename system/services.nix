{ config, pkgs, ... }:

{
    services = {
        libinput = {
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

        xserver = {
            enable = true;
            xkb.layout = "us";
            xkb.variant = "";
        };
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;

        flatpak.enable = false;

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
    };
}
