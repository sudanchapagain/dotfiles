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
        gnome-solanum
        sushi
        switcheroo
        tuba
        vscode
        warp

        jetbrains-toolbox

        # language
        nushell
        harper hx-lsp
        niv nixd nixfmt

        marksman markdown-oxide
        yaml-language-server tombi
        jq flatpak-xdg-utils flatpak-builder
        texlab tex-fmt texliveMedium bibtex-tidy

        bazel_9 bazel-buildtools
        meson mesonlsp ninja
        pkg-config pkgconf gnumake just just-formatter just-lsp
        clang clang-tools libgccjit lldb libcxx libgcc
        pre-commit devenv
        cmake cmake-format cmake-language-server cmake-lint

        python3 zed-editor

        gradle maven
        jdk11 jdk17 jdk25
        jdt-language-server google-java-format
        kotlin kotlin-native

        gst_all_1.gst-devtools gst_all_1.gst-editing-services gst_all_1.gst-libav
        gst_all_1.gst-plugins-bad gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer gst_all_1.gstreamermm gst_all_1.gst-vaapi

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
        chayang
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
            pname = "chv";
            version = "1.0.0";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/call-history-viewer";
                rev = "7809f55e0d4ac4296191046674a1e7e065466a34";
            };
            buildInputs = [ pkgs.tinyxml-2 ];
            nativeBuildInputs = [
                pkgs.meson
                pkgs.ninja
                pkgs.pkg-config
            ];
        })

        (pkgs.stdenv.mkDerivation {
            pname = "unduck";
            version = "1.0.0";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/unduck";
                rev = "46dd5b7d1bd074b594e0bb83ef0de94e486bb8c6";
            };
            nativeBuildInputs = [
                pkgs.meson
                pkgs.ninja
                pkgs.pkg-config
            ];
        })

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
            pname = "dotf";
            version = "3.0.0";
            src = fetchGit {
                url = "https://github.com/sudanchapagain/dotf";
                rev = "8c8007ab094f11ad5912ae70f2906ce8f75aa30e";
            };
            buildInputs = [
                pkgs.fmt
                pkgs.argparse
                pkgs.tomlplusplus
            ];
            nativeBuildInputs = [
                pkgs.meson
                pkgs.ninja
                pkgs.pkg-config
            ];
        })
    ];
}
