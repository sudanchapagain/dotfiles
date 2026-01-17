{ pkgs, ... }:

{
    fonts = {
        enableGhostscriptFonts = true;
        packages = with pkgs; [
            corefonts
            inter
            jetbrains-mono
            lohit-fonts.nepali
            nerd-fonts.jetbrains-mono
            noto-fonts
            noto-fonts-color-emoji
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

        podman
        podman-compose

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
        graphviz
        grex
        hyperfine
        killall
        killport
        monolith
        mpd
        mysql84
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
        zola
        zoxide

        # os
        efibootmgr
        refind

        # desktop
        niri
        waybar
        swaybg
        swaylock
        swayidle
        swaynotificationcenter
        swayosd
        libnotify
        fuzzel
        playerctl
        brightnessctl
        wl-clipboard

        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.gsconnect
        gnomeExtensions.nepali-calendar
        gnomeExtensions.runcat

        # my packages
        # (pkgs.stdenv.mkDerivation {
        #     pname = "bikram";
        #     version = "1.1.1";

        #     src = pkgs.fetchgit {
        #         url = "https://github.com/sudanchapagain/bikramsambat";
        #         rev = "418a88db9ec0857e540ea019932156bc2cd89a29";
        #         sha256 = "LwM7yXtfkv00QZTFfnNhnhlhBsdpGYCz2o/R2xjiWcQ=";
        #     };

        #     nativeBuildInputs = [
        #         pkgs.gcc
        #         pkgs.meson
        #         pkgs.ninja
        #     ];

        #     buildPhase = ''
        #         meson setup build $src \
        #             --prefix=$out \
        #             --bindir=$out/bin \
        #             --libdir=$out/lib \
        #             --includedir=$out/include \
        #             --buildtype=release
        #         meson compile -C build
        #         meson install -C build
        #     '';

        #     installPhase = ''
        #         meson install -C build
        #     '';
        # })

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

        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "arrow";
            version = "6.0.0";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/arrow";
                rev = "1040b48aeadc4c6bbe5dbc4d777fa74fb5290327";
            };
            nativeBuildInputs = with pkgs; [ pkg-config ];
            buildInputs = with pkgs; [ openssl ];
            doCheck = false;
        })

        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "mediamark";
            version = "0.0.1";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/mediamark";
                rev = "735081664bdb6d7cee35bace18d9bf73527af990";
            };
            doCheck = false;
        })
    ];
}
