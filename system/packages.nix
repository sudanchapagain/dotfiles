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
            maple-mono.NormalNL-NF-unhinted
            lohit-fonts.nepali
            noto-fonts
        ];

        fontconfig = {
            enable = true;
            defaultFonts = {
                monospace = [ "MapleMonoNormalNLNF" ];
                sansSerif = [ "Inter" ];
            };
        };
    };

    programs.niri.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # cursor
        banana-cursor

        # apps
        adwaita-icon-theme
        alacritty
        baobab
        authenticator
        blanket
        citations
        curtail
        dconf-editor
        decibels
        eartag
        errands
        eyedropper
        file-roller
        foliate
        fragments
        gapless
        glib
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-disk-utility
        gnome-font-viewer
        gnome-keyring
        gnome-keysign
        gnome-podcasts
        gnome-secrets
        gnome-software
        gnome-text-editor
        gnome-user-share
        gradia
        gsettings-desktop-schemas
        helix
        hugo
        keypunch
        libreoffice
        loupe
        mousai
        nautilus
        newsflash
        paper-clip
        papers
        pdfarranger
        plattenalbum
        refine
        rnote
        shortwave
        showtime
        snapshot
        solanum
        sushi
        switcheroo
        tuba
        vscode
        warp

        # language
        nushell
        vala
        harper hx-lsp
        yaml-language-server tombi
        marksman markdown-oxide
        texlab
        tex-fmt
        texliveMedium
        clang clang-tools libgccjit lldb
        meson mesonlsp ninja
        pkg-config gnumake
        cmake cmake-format cmake-language-server cmake-lint

        niv nixd nixfmt
        djlint python3 ruff zuban uv

        raylib
        # glib glibc dbus dbus-glib gtk3 gtk4 gtk3.dev gtk4.dev gio-sharp
        # graphene pango libsoup_3 libadwaita gobject-introspection
        # blueprint-compiler gettext gsettings-desktop-schemas
        # desktop-file-utils appstream appstream-glib libGL libGLU glew glfw
        # freeglut itstool

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
        ffmpeg ffmpegthumbnailer
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
        television bat # i hate bat but need for TV to work.
        tokei
        tree
        ungoogled-chromium
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

        (pkgs.stdenv.mkDerivation {
            pname = "bikramsambat";
            version = "1.1.1";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/bikramsambat";
                rev = "0ee00f3d8bc1cca0c01f12b6945ed9b1ec706de8";
            };
            nativeBuildInputs = [
                pkgs.meson
                pkgs.ninja
                pkgs.pkg-config
            ];
        })

        (pkgs.stdenv.mkDerivation {
            pname = "chv";
            version = "1.0.0";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/call-history-viewer";
                rev = "f0b2ff59ead38f8190aacc3ea34491322070b1de";
            };
            buildInputs = [ pkgs.tinyxml-2 ];
            buildPhase = "make";
            installPhase = ''
                mkdir -p $out/bin
                cp build/app $out/bin/chv
            '';
        })

        (pkgs.stdenv.mkDerivation {
            pname = "unduck";
            version = "1.0.0";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/unduck";
                rev = "cc8d9fc90b19988e67f204818b434a9cda4d165c";
            };
            buildPhase = "make";
            installPhase = ''
                mkdir -p $out/bin
                cp build/unduck $out/bin/unduck
                cp build/source.json $out/bin/source.json
            '';
        })

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
