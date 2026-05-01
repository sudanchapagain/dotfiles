{ ... }:

{
    # Set your time zone.
    time = {
        timeZone = "Asia/Kathmandu";
        hardwareClockInLocalTime = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    xdg = {
        portal = {
            enable = true;
            wlr.enable = true;
            extraPortals = [ ];
        };
        mime = {
            enable = true;
            defaultApplications = {
                "text/html" = "app.zen_browser.zen.desktop";
                "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
                "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
                "application/pdf" = "org.gnome.Papers.desktop";
                "image/png" = "org.gnome.Loupe.desktop";
                "image/jpeg" = "org.gnome.Loupe.desktop";
                "audio/mpeg" = "io.bassi.Decibels.desktop";
                "audio/flac" = "io.bassi.Decibels.desktop";
            };
        };
    };

    environment.sessionVariables = {
        EDITOR = "hx";
        XDG_BIN_HOME = "$HOME/.local/bin";
        PATH = [ "$XDG_BIN_HOME" ];
    };
}
