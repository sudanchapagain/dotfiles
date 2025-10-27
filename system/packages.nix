{ config, pkgs, ... }:

{
    fonts = {
        enableGhostscriptFonts = true;
        packages = with pkgs; [
            #liberation_ttf
            corefonts
            font-awesome
            inter
            jetbrains-mono
            lohit-fonts.nepali
            nerd-fonts.jetbrains-mono
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
        ];

        fontconfig = {
            enable = true;
            defaultFonts = {
                serif = [ "Noto Serif" ];
                monospace = [ "JetBrains Mono" ];
                sansSerif = [
                    "Inter"
                    "Noto Sans"
                ];
                emoji = [ "Noto Color Emoji" ];
            };
        };
    };

    environment.gnome.excludePackages = with pkgs; [
        epiphany
        evince
        geary
        gnome-console
        gnome-tour
        gnome-maps
        simple-scan
        totem
    ];

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # apps
        alacritty
        anytype
        baobab
        authenticator
        blanket
        citations
        curtail
        dconf-editor
        eartag
        errands
        escambo
        eyedropper
        foliate
        fragments
        gapless
        gnome-podcasts
        gnome-secrets
        gradia
        helix
        keypunch
        libreoffice
        mousai
        newsflash
        paper-clip
        papers
        plattenalbum
        protonmail-desktop
        refine
        rnote
        shortwave
        showtime
        solanum
        switcheroo
        telegram-desktop
        tuba
        viber
        vscode
        warp

        # language
        cargo
        cargo-binstall
        clang
        clippy
        harper
        just
        marksman
        meson
        niv
        nixd
        nixfmt
        nushell
        python3
        ruff
        rustc
        rustfmt
        rust-analyzer
        steel
        taplo
        tinymist
        tombi
        typst
        uv
        zuban

        # tools
        carapace
        carapace-bridge
        bacon
        bottom
        delta
        dig
        dua
        eza
        fastfetch
        fd
        ffmpeg
        ffmpegthumbnailer
        file
        fzf
        git
        grex
        hyperfine
        killall
        killport
        monolith
        mpd
        nh
        ouch
        p7zip
        pandoc
        ripgrep
        simple-http-server
        stress
        television
        tokei
        tree
        unrar-wrapper
        unzip
        wl-clipboard
        yazi
        yt-dlp
        zellij
        zoxide

        # os
        efibootmgr
        home-manager
        refind

        # desktop
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.gsconnect
        gnomeExtensions.nepali-calendar
        gnomeExtensions.runcat
    ];
}
