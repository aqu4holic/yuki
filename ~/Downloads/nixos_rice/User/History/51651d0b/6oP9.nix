# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:
let username = "blackwhite";
in {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.blackwhite = {
        isNormalUser = true;
        description = "blackwhite";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            #  thunderbird
            vim
            wget
            vscode
        ];
    };

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];

    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # do garbage collection weekly to keep disk usage low
    nix.gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
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
        LC_TIME = "vi_VN";
    };

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = false;


    # Configure keymap in X11
    # services.xserver = {
    #    layout = "us";
    #    xkbVariant = "";
    # };

    services.xserver = {
    enable = true;
    
    displayManager = {
        lightdm = {
        enable = true;
        };
    };

    windowManager.bspwm = {
        enable = true;
    };

    layout = "us";
    xkbVariant = "";
    };

    fonts = {
        packages = with pkgs; [
        # icon fonts
        material-design-icons

        # normal fonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji

        # nerdfonts
        (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
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

    programs.dconf.enable = true;

    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        fish
        kitty
        curl
        git
        sysstat
        lm_sensors # for `sensors` command
        # minimal screen capture tool, used by i3 blur lock to take a screenshot
        # print screen key is also bound to this tool in i3 config
        scrot
        fastfetch
        xfce.thunar # xfce4's file manager
        nnn # terminal file manager
        ranger # same as the above
        zathura # pdf viewer

        # for bspwm
        bspwm
        sxhkd
        rofi
        dunst
        picom
        polybar
    ];

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
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

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
}
