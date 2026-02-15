{ pkgs, ... }:

{
    fonts = {
        enableGhostscriptFonts = true;
        packages = with pkgs; [
            # essential
            corefonts
            inter
            libertine
            liberation_ttf

            # cute
            maple-mono.NormalNL-NF-unhinted
            comic-mono
            comic-relief

            # additional support
            lohit-fonts.nepali
            noto-fonts
            noto-fonts-color-emoji
        ];

        fontconfig = {
            enable = true;
            defaultFonts = {
                serif = [ "Noto Serif" ];
                monospace = [ "MapleMonoNormalNLNF" ];
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
        gnome-tour
        gnome-maps
        gnome-music
        simple-scan
        totem
    ];
    programs.niri.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # cursor
        banana-cursor

        # apps
        alacritty
        baobab
        authenticator
        blanket
        citations
        curtail
        dconf-editor
        eartag
        errands
        eyedropper
        foliate
        fragments
        gapless
        gnome-podcasts
        gnome-secrets
        gradia
        helix
        hugo
        keypunch
        libreoffice
        mousai
        newsflash
        paper-clip
        papers
        pdfarranger
        plattenalbum
        refine
        rnote
        shortwave
        showtime
        solanum
        switcheroo
        tuba
        vscode
        warp

        # language
        nushell
        typst

        harper
        marksman
        tinymist
        tombi

        clang
        clang-tools
        libgccjit
        lldb

        meson
        mesonlsp
        pkg-config
        ninja
        gnumake

        niv
        nixd
        nixfmt

        djlint
        python3
        ruff
        zuban
        uv

        # tools
        carapace
        carapace-bridge
        binsider
        btop
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
        ghostscript
        git
        graphviz
        grex
        hyperfine
        killall
        killport
        monolith
        mpd
        mysql84
        postgresql
        nh
        ouch
        p7zip
        pandoc
        ripgrep
        simple-http-server
        sqlite
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
        refind

        # desktop
        cliphist
        niri
        waybar
        swaybg
        swaylock
        swayidle
        swaynotificationcenter
        libnotify
        fuzzel
        playerctl
        brightnessctl
        wl-clipboard
        wlsunset
        wl-mirror

        xwayland
        xwayland-satellite

        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.nepali-calendar
        gnomeExtensions.runcat

        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "dotf";
            version = "2.0.0";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/dotf";
                rev = "f19f065452c76f1799d3b9caf55a341213239ed0";
            };
            doCheck = false;
        })
    ];
}
