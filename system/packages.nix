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
        # core GUI apps, compat stuff, and useful GUI applications
        banana-cursor adwaita-icon-theme
        alacritty
        authenticator
        censor
        citations
        eyedropper
        foliate
        fragments
        gradia
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-font-viewer
        gnome-text-editor
        gnome-software
        inkscape
        krita
        libreoffice
        nautilus
        newsflash
        paper-clip
        papers
        pdfarranger
        planify
        rnote
        showtime
        # tuba
        warp

        baobab file-roller gnome-disk-utility gsettings-desktop-schemas gnome-user-share # utils
        gnome-keysign gnome-secrets # keys
        dconf-editor refine # config

        snapshot loupe switcheroo curtail # image
        eartag blanket decibels gapless gnome-podcasts mousai plattenalbum shortwave # audio
        helix android-studio-full android-studio-tools vscode zed-editor # editor
        vscode zed-editor

        # random tools and stuff
        delta git
        carapace carapace-bridge zoxide zellij # make cli good
        dig monolith simple-http-server # networking
        dua fd fzf ripgrep ripgrep-all grex # to work with files in cli
        binsider btop television bat tokei fastfetch
        hugo yazi pandoc # yt-dlp
        ffmpeg ffmpegthumbnailer
        killall killport
        hyperfine stress # benchmark
        eza tree file graphviz ghostscript unrar-wrapper unzip ouch p7zip # compat stuff and other

        # language
        nushell python3
        jq pre-commit harper hx-lsp marksman markdown-oxide
        yaml-language-server tombi
        devenv niv nixd nixfmt nh # nix

        texlab tex-fmt texliveMedium bibtex-tidy

        # c/c++
        meson mesonlsp ninja
        clang clang-tools libgccjit lldb libcxx libgcc
        pkg-config pkgconf gnumake cmake
        cmake-format cmake-language-server cmake-lint

        # jvm
        gradle maven jdk11 jdk17 jdk25
        jdt-language-server google-java-format

        # apparently i dont have these.
        gst_all_1.gst-devtools gst_all_1.gst-editing-services gst_all_1.gst-libav
        gst_all_1.gst-plugins-bad gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer gst_all_1.gstreamermm gst_all_1.gst-vaapi

        # os
        efibootmgr
        refind

        # desktop
        chayang
        niri waybar fuzzel
        swaybg swaylock swayidle
        swaynotificationcenter libnotify
        playerctl brightnessctl
        cliphist wl-clipboard
        wlsunset wl-mirror

        # compat
        xwayland
        xwayland-satellite

        # personal
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
