{ config, pkgs, lib, ... }:
let
    username = "blackwhite";
    bamboo = pkgs.callPackage ./pkgs/ibus-bamboo.nix {};
in
{
    imports = [
        ./services.nix
        ./programs.nix
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
        builders-use-substitutes = true;
        substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
            "https://cuda-maintainers.cachix.org"
            "https://anyrun.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
            "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        ];
    };

    # Allow unfree packages
    nixpkgs.config = {
        # cudaSupport = true;
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

    # autologin
    services.getty.greetingLine = ''
        <<< ${config.system.nixos.distroName} ${config.system.nixos.label} (\m) @ \l >>>
        <<< \t, \d >>>
        <<< ${username}@${config.networking.hostName} >>>
    '';
    services.getty.helpLine = lib.mkForce ''If you don't know what you're doing, leave :)'';
    systemd.services = {
        "getty@tty1" = {
            overrideStrategy = "asDropin";
            serviceConfig.ExecStart = [ ""
                ''
                    @${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} \
                    -o '-p -- ${username}' --noclear --skip-login --keep-baud %I 115200,38400,9600 $TERM
                ''
            ];
        };

        "getty@tty2" = {
            overrideStrategy = "asDropin";
            serviceConfig.ExecStart = [ ""
                ''
                    @${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} \
                    -o '-p -- ${username}' --noclear --skip-login --keep-baud %I 115200,38400,9600 $TERM
                ''
            ];
        };
    };

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
        # type = "ibus";
        # ibus.engines = with pkgs; [
        #     bamboo
        #     ibus-engines.anthy
        # ];

        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
            fcitx5-bamboo
        ];
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
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
        ];

        enableDefaultPackages = false;

        fontconfig.defaultFonts = {
            serif = ["Noto Serif" "Noto Color Emoji"];
            sansSerif = ["Noto Sans" "Noto Color Emoji"];
            monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
            emoji = ["Noto Color Emoji"];
        };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    programs.noisetorch.enable = true;

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
    environment.sessionVariables = {
        # GTK portal config
        # GTK_USE_PORTAL = 1;
        NIXPKGS_ALLOW_UNFREE = 1;

        # ibus
        # GTK_IM_MODULE = "ibus";
        # QT_IM_MODULE = "ibus";
        # CLUTTER_IM_MODULE = "ibus";
        # GLFW_IM_MODULE = "ibus";
        # XMODIFIERS = "@im=ibus";

        # fcitx5
        # GTK_IM_MODULE = lib.mkForce null;
        # QT_IM_MODULE = "fcitx";
        # XMODIFIERS = "@im=fcitx";
        # GLFW_IM_MODULE = "fcitx";
        # INPUT_METHOD = "fcitx";
        # IMSETTINGS_MODULE = "fcitx";
        # CLUTTER_IM_MODULE = "fcitx";
        # SDL_IM_MODULE = "fcitx";
        # QT4_IM_MODULE = "fcitx";

        # java
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

        # direnv shell
        DIRENV_WARN_TIMEOUT = 0;

        # qt scale
        # QT_SCALE_FACTOR = "1.3";
    };
}
