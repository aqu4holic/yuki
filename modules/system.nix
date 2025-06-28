# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
    username = "blackwhite";

    bamboo = pkgs.callPackage ./pkgs/ibus-bamboo.nix {};
in
{
    imports = [
        ./services.nix
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [
            "input"
            "networkmanager"
            "wheel"
            "video"
            "audio"
            "docker"
            "adbusers"
            "libvirtd"
        ];
    };

    security = {
        sudo = {
            enable = false;
            execWheelOnly = true;
            wheelNeedsPassword = true;
            extraConfig = ''
                Defaults timestamp_timeout=-1
                Defaults env_keep += "TERM TERMINFO"
            '';
        };

        sudo-rs = {
            enable = true;
            execWheelOnly = true;
            wheelNeedsPassword = true;
            extraConfig = ''
                Defaults timestamp_timeout=2628000000000000
                Defaults env_keep += "TERM TERMINFO"
            '';
        };
    };

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
            "https://cuda-maintainers.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
    };

    # Allow unfree packages
    nixpkgs.config = {
        allowUnfree = true;
        allowInsecure = true;
        allowBroken = true;
        allowUnfreePredicate = _: true;
    };

    nixpkgs.config.permittedInsecurePackages = [
        "xpdf-4.05"
        "openssl-1.1.1w"
    ];

    # do garbage collection weekly to keep disk usage low
    nix.gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
    };

    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;
    nix.settings.trusted-users = [ "root" username ];

    # Set your time zone.
    time.timeZone = "Asia/Ho_Chi_Minh";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "vi_VN";
        LC_IDENTIFICATION = "vi_VN";
        LC_MEASUREMENT = "vi_VN";
        LC_MONETARY = "vi_VN";
        LC_NAME = "vi_VN";
        LC_NUMERIC = "vi_VN";
        LC_PAPER = "vi_VN";
        LC_TELEPHONE = "vi_VN";
        LC_TIME = "en_GB.UTF-8";
    };

    i18n.inputMethod = {
        enable = true;
        type = "ibus";
        ibus.engines = with pkgs; [
            bamboo
            ibus-engines.anthy
        ];
    };

    systemd.services."getty@tty1" = {
        overrideStrategy = "asDropin";
        serviceConfig.ExecStart = ["" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} -o '-p -- ${username}' --noclear --skip-login --keep-baud %I 115200,38400,9600 $TERM"];
    };

    systemd = {
        targets = {
            sleep = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            suspend = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            hibernate = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            "hybrid-sleep" = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
        };
    };

    security.protectKernelImage = false;

    # touchpad config
    services.libinput = {
        enable = true;

        touchpad = {
            tapping = true;
            middleEmulation = true;
            naturalScrolling = true;
        };
    };

    services.fwupd.enable = true;

    fonts = {
        packages = with pkgs; [
            # normal fonts
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
            newcomputermodern

            # nerdfonts
            # (
            #     nerdfonts.override {
            #         fonts = [
            #             "FiraCode"
            #             "JetBrainsMono"
            #         ];
            #     }
            # )
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
        ];

        # use fonts specified by user rather than default ones
        enableDefaultPackages = false;

        # user defined fonts
        # the reason there's Noto Color Emoji everywhere is to override DejaVu's
        # B&W emojis that would sometimes show instead of some Color emojis
        fontconfig.defaultFonts = {
            serif = ["Noto Serif" "Noto Color Emoji"];
            sansSerif = ["Noto Sans" "Noto Color Emoji"];
            monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
            emoji = ["Noto Color Emoji"];
        };
    };

    programs.nix-ld = {
        enable = true;

        libraries = with pkgs; [
            zlib
            zstd
            stdenv.cc.cc
            stdenv.cc
            curl
            openssl
            attr
            libssh
            bzip2
            libxml2
            acl
            libsodium
            util-linux
            xz
            systemd
        ];
    };

    programs.dconf.enable = true;
    programs.adb.enable = true;

    # programs.zsh.enable = true;
    # users.defaultUserShell = pkgs.zsh;
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    # openvpn
    programs.openvpn3 = {
        enable = true;
        package = pkgs.openvpn3;
        log-service.settings = {
            log_level = 6;
            log_dbus_details = true;
            journald = true;
        };
        netcfg.settings = {
            systemd_resolved = true;
        };
    };
    services.resolved.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        neovim
        fish
        # zsh
        kitty
        curl
        git
        sysstat
        lm_sensors # for `sensors` command
        fastfetch
        yazi
        zathura # pdf viewer

        screen

        # network
        networkmanagerapplet

        # audio
        pulseaudio
        noisetorch
        playerctl
        pamixer

        # display
        brightnessctl

        # for customization
        i3lock-color

        # utils
        killall
        xdotool
        xorg.xev

        # libs
        bc
        libnotify
        libgcc
        gcc
        cmake

        # devs
        bun
        go

        # rust
        # rustup
        # rustc
        # cargo

        # jre_minimal
        # jdk22
    ];

    # Enable CUPS to print documents.
    services.printing.enable = true;

    environment.etc."current_system_packages".text =
    let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
        formatted;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        # jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        # media-session.enable = true;
    };

    programs.noisetorch.enable = true;

    # virtualisation
    virtualisation = {
        docker = {
            enable = true;
            # daemon.settings = {
            #     experimental = true;
            #     default-address-pools = [
            #         {
            #             base = "172.30.0.0/16";
            #             size = 24;
            #         }
            #     ];
            #     dns = [ "1.1.1.1" "8.8.8.8" ];
            #     iptables = false;
            #     registry-mirrors = [ "https://mirror.gcr.io" ];
            # };

            # use docker without root access (rootless docker)
            rootless = {
                enable = false;
                # daemon.settings = {
                #     dns = [ "1.1.1.1" "8.8.8.8" ];
                #     registry-mirrors = [ "https://mirror.gcr.io" ];
                # };
                setSocketVariable = true;
            };
        };

        # # virt-manager
        # spiceUSBRedirection.enable = true;
        # libvirtd = {
        #     enable = true;
        #     qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        # };
    };
    # services.qemuGuest.enable = true;
    # services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
    # programs.virt-manager.enable = true;

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
            General = {
                Name = "yuki";
                ControllerMode = "dual";
                FastConnectable = "true";
                Experimental = "true";
            };

            Policy = {
                AutoEnable = "true";
            };
        };
    };
    services.blueman.enable = true;

    # set environment variables
    environment.variables = {
        # GTK portal config
        # GTK_USE_PORTAL = 1;

        # ibus
        GTK_IM_MODULE = "ibus";
        QT_IM_MODULE = "ibus";
        QT4_IM_MODULE = "ibus";
        CLUTTER_IM_MODULE = "ibus";
        GLFW_IM_MODULE = "ibus";
        XMODIFIERS = "@im=ibus";

        # java
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

        # direnv shell
        DIRENV_WARN_TIMEOUT = 0;

        # qt scale
        QT_SCALE_FACTOR = "1.3";
    };
}
