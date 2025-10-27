{ self, config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    # Bootloader.
    boot = {
        supportedFilesystems = [
            "ntfs"
            "btrfs"
        ];
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        # initrd.systemd.enable = true;
        # initrd.services.lvm.enable = true;

        kernel.sysctl = {
            # TCP optimization.
            # TCP Fast Open is a TCP extension that reduces network latency by
            # packing data in the sender's initial TCP SYN. Setting 3 = enable TCP
            # Fast Open for both incoming and outgoing connections:
            "net.ipv4.tcp_fastopen" = 3;

            # Bufferbloat mitigations + slight improvement in throughput & latency
            "net.ipv4.tcp_congestion_control" = "bbr";
            "net.core.default_qdisc" = "cake";

            "vm.swappiness" = 65;
        };

        kernelPackages = pkgs.linuxPackages_latest;
        kernelModules = [ "tcp_bbr" ];
    };

    zramSwap = {
        enable = true;
        algorithm = "lz4";
    };

    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            auto-optimise-store = true;
        };

        gc.automatic = true;
        gc.persistent = true;
        gc.dates = "weekly";
        gc.options = "--delete-older-than 7d";
    };
    nixpkgs.config.allowUnfree = true;

    networking = {
        hostName = "crimson";
        networkmanager.enable = true;
        enableIPv6 = false;
        firewall = {
            enable = false;
            #allowedTCPPorts = [ 59010 59011 ];
            #allowedUDPPorts = [ 59010 59011 ];
        };
    };
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Set your time zone.
    time = {
        timeZone = "Asia/Kathmandu";
        hardwareClockInLocalTime = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    powerManagement = {
        enable = true;
        cpuFreqGovernor = "balanced";
    };

    hardware = {
        bluetooth = {
            enable = true;
            powerOnBoot = false;
        };

        # Hardware acceleration.
        graphics = {
            enable = true;
            extraPackages = with pkgs; [
                intel-media-driver
                libvdpau-va-gl
            ];
        };
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
    };

    services.libinput = {
        enable = true;
        mouse = {
            accelProfile = "adaptive";
            accelSpeed = "-0.5";
            scrollMethod = "twofinger";
        };

        touchpad = {
            accelProfile = "adaptive";
            accelSpeed = "-0.5";
            scrollMethod = "twofinger";
            tapping = true;
            disableWhileTyping = true;
        };
    };

    services = {
        xserver = {
            enable = true;
            xkb.layout = "us";
            xkb.variant = "";
        };
        desktopManager.gnome.enable = true;
        displayManager.gdm.enable = true;
    };

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ ];
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
    };

    systemd = {
        user = {
            #startServices = "sd-switch";
            services.polkit-gnome-authentication-agent-1 = {
                description = "polkit-gnome-authentication-agent-1";
                wantedBy = [ "graphical-session.target" ];
                wants = [ "graphical-session.target" ];
                after = [ "graphical-session.target" ];
                serviceConfig = {
                    Type = "simple";
                    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                    Restart = "on-failure";
                    RestartSec = 1;
                    TimeoutStopSec = 10;
                };
            };
        };
    };

    services = {
        flatpak.enable = true;
        # printing.enable = false;
        #openssh.enable = true;
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            #jack.enable = true;

            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            #media-session.enable = true;
        };
        dbus.enable = true;
        gvfs.enable = true;
        gnome.gnome-keyring.enable = true;
        devmon.enable = true; # monitors for new storage devices
        udisks2.enable = true; # allows apps like Nautilus to query and manipulate storage devices
        blueman.enable = true; # GUI Bluetooth manager
        fstrim = {
            enable = true;
            interval = "monthly";
        }; # Trim SSD in the background, once every month.
        logind.settings.Login = {
            HandlePowerKey = "suspend";
        };

        # Enable touchpad support (enabled default in most desktopManager).
        # xserver.libinput.enable = true;

    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
        # password: temp a
        root.initialHashedPassword = "$6$FRmKgElD/80xQiXn$aF.tKv0VOLj9D3aUJjoYsj3AzSj1rq5fVooE7tgtNuTawt8ZWgaRyUUxsikX5whbna4jrzXrDZmVFqik.kyc2/";

        crimson = {
            isNormalUser = true;
            description = "crimson";
            extraGroups = [
                "networkmanager"
                "wheel"
                "flatpak"
                "audio"
                "video"
                "root"
            ];

            # password: temp b
            initialHashedPassword = "$6$iLmo7C9VoAnJZ6v1$qCSORkbiY44IbcrrF1DcTnJtpOkqeD2tGgUoaDgtzPdFqKWKJ28AhJqmuOf8IWoSNu2DQJM.QlWO1Ok05kFgp0";

            packages = with pkgs; [
                #  thunderbird
            ];
        };
    };

    # Install firefox.
    programs.firefox.enable = true;
    programs.niri.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # apps
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
        warp
        # telegram-desktop

        # dev tools
        alacritty
        emacs-pgtk
        helix
        vscode

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
        nodejs
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
        bacon
        bat
        btop
        countryfetch
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
        jrnl
        killport
        python313Packages.faker
        monolith
        ouch
        pandoc
        pciutils
        ripgrep
        simple-http-server
        stress
        television
        timg
        tokei
        tree
        vivid
        wget
        yazi
        yt-dlp
        zellij
        zoxide

        # os tools
        carapace
        carapace-bridge
        mpd
        nh
        wl-clipboard

        # os
        efibootmgr
        flatpak
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

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}
