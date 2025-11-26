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
        podman-tui

        # language
        biome
        nushell
        typst
        steel
        just

        harper
        marksman
        tinymist
        tombi
        racket-minimal

        clang
        clang-tools
        libgccjit

        cmake
        gnumake
        meson
        mesonlsp
        pkg-config
        ninja

        cargo
        cargo-binstall
        clippy
        lldb
        rustc
        rustfmt
        rust-analyzer

        ghc
        cabal-install
        haskell-language-server
        hlint
        fourmolu
        ghcid

        niv
        nixd
        nixfmt

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
        stress
        television
        tokei
        tree
        unrar-wrapper
        unzip
        wl-clipboard
        yazi
        yt-dlp
        zed-editor
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

        # my packages
        (pkgs.rustPlatform.buildRustPackage rec {
            pname = "dotf";
            version = "2.0.0";
            cargoLock.lockFile = "${src}/Cargo.lock";
            src = builtins.fetchGit {
                url = "https://github.com/sudanchapagain/dotf";
                rev = "ac1522b829099fa9a7171ccc7675bde4d0be8dd0";
            };
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
    ];
}
