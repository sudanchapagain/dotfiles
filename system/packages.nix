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

    environment.gnome.excludePackages = (
        with pkgs;
        [
            epiphany
            evince
            geary
            simple-scan
            totem
        ]
    );

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
        tuba
        vscode
        warp
        # telegram-desktop

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
        dua
        eza
        fastfetch
        fd
        ffmpeg
        fzf
        git
        grex
        hyperfine
        killport
        monolith
        mpd
        nh
        ouch
        pandoc
        ripgrep
        simple-http-server
        stress
        television
        tokei
        tree
        wl-clipboard
        yazi
        yt-dlp
        zellij
        zoxide

        # os
        efibootmgr
        # flatpak
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
