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
        biome
        nushell
        typst
        just
        steel
        racket-minimal

        harper
        marksman
        tinymist
        tombi

        clang
        clang-tools
        libgccjit

        cmake
        gnumake
        meson
        mesonlsp
        pkg-config
        ninja
        zig
        zls

        cargo
        cargo-binstall
        clippy
        lldb
        rustc
        rustfmt
        rust-analyzer

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
        zoxide

        # os
        efibootmgr
        refind

        # desktop
        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.gsconnect
        gnomeExtensions.nepali-calendar
        gnomeExtensions.runcat

        # my packages
        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "dotf";
            version = "2.0.0";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = builtins.fetchGit {
                url = "https://github.com/sudanchapagain/dotf";
                rev = "ac1522b829099fa9a7171ccc7675bde4d0be8dd0";
            };
            doCheck = false;
        })

        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "arrow";
            version = "6.0.0";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = builtins.fetchGit {
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
            src = builtins.fetchGit {
                url = "https://github.com/sudanchapagain/mediamark";
                rev = "735081664bdb6d7cee35bace18d9bf73527af990";
            };
            doCheck = false;
        })
    ];
}
