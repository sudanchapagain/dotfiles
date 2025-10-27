{ config, pkgs, ... }:

{
    services.libinput = {
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

    services = {
        xserver = {
            enable = true;
            xkb.layout = "us";
            xkb.variant = "";
        };
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
    };

    services = {
        flatpak.enable = false;
        # flatpak-repo = {
        #     wantedBy = [ "multi-user.target" ];
        #     path = [ pkgs.flatpak ];
        #     script = ''
        #         flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        #     '';
        # };

        # printing.enable = false;
        #openssh.enable = true;
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            #jack.enable = true;

            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            #media-session.enable = true;
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
