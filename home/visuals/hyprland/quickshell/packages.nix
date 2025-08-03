{ inputs, config, pkgs, libs, ... }:
let
    illogical-impulse-oneui4-icons = pkgs.callPackage ./illogical-impulse-oneui4-icons {};
in
{
    services.gammastep.enable = true;
    services.gammastep.provider = "geoclue2";

    home.packages = with pkgs; [
        geoclue2
        illogical-impulse-oneui4-icons
        # # AUDIO #
        cava
        lxqt.pavucontrol-qt
        wireplumber
        libdbusmenu-gtk3
        playerctl

        # # BACK LIGNT#
        brightnessctl
        ddcutil

        # # BASIC #
        axel
        bc
        # coreutils
        cliphist
        # cmake
        curl
        rsync
        wget
        libqalculate
        ripgrep
        jq
        # meson
        fish
        foot
        fuzzel
        matugen
        mpv
        mpvpaper

        xdg-user-dirs

        # # FONT THEMES #
        adw-gtk3
        #   breeze-plus #TODO need monaula install
        eza
        #   fish
        #   fontconfig
        python313Packages.kde-material-you-colors
        #   kitty
        #   matugen
        #   starship
        #   # ttf-readex-pro #TODO need monaula install
        #   # ttf-jetbrains-mono-nerd
        material-symbols
        rubik
        inputs.nur.legacyPackages."${system}".repos.skiletro.gabarito
        # # HYPRLAND #
        wl-clipboard

        # # KDE #
        kdePackages.bluedevil
        gnome-keyring
        # networkmanager # normal handel with nixos services
        kdePackages.plasma-nm
        kdePackages.polkit-kde-agent-1

        # # SCREEN CAPUTUER #
        swappy
        wf-recorder
        hyprshot
        tesseract
        slurp

        # # TOOLKIT #
        upower
        wtype
        ydotool

        # # PYTHON #
        #   # clang
        # uv
        #   gtk4
        #   libadwaita
        libsoup_3
        libportal-gtk4
        gobject-introspection
        sassc
        opencv
        (python3.withPackages (python-pkgs: with python-pkgs; [
            build
            pillow
            setuptools-scm
            wheel
            pywayland
            psutil
            materialyoucolor
            libsass
            material-color-utilities
            setproctitle
        ]))


        # # WIDGETS #
        glib
        swww
        translate-shell
        wlogout

    ] ++ (with pkgs.nerd-fonts; [
        # nerd fonts
        ubuntu
        ubuntu-mono
        jetbrains-mono
        caskaydia-cove
        fantasque-sans-mono
        mononoki
        space-mono
    ]);
}