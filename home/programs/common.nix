{ inputs, config, pkgs, libs, ... }:
{
    imports = [
        ./python
        # ./fcd
    ];

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
        # here is some command line tools i use frequently
        # feel free to add your own or remove some of them

        (
            writeShellScriptBin "clean_cache" ''
                nix-collect-garbage --delete-old
                nix-store --gc
                sudo nix-collect-garbage -d
                sudo /run/current-system/bin/switch-to-configuration boot
            ''
        )

        # (
        #     writeShellScriptBin "venv_fix" ''
        #
        #     ''
        # )

        # archives
        zip
        xz
        unzip
        p7zip
        rar
        unar

        # utils
        ripgrep # recursively searches directories for a regex pattern
        yq # yaml processor
        yj # wtf is this
        eza # A modern replacement for ‘ls’
        fzf # A command-line fuzzy finder
        fd
        bat # file preview
        zoxide # command history
        # glow
        # miller
        # hexyl
        xdragon # drag and drop
        git-filter-repo
        postman

        ffmpeg-full
        poppler
        ffmpegthumbnailer

        texliveFull

        # networking tools
        mtr # A network diagnostic tool
        iperf
        dnsutils  # `dig` + `nslookup`
        ldns # replacement of `dig`, it provide the command `drill`
        aria2 # A lightweight multi-protocol & multi-source command-line download utility
        socat # replacement of openbsd-netcat
        nmap # A utility for network discovery and security auditing
        ipcalc  # it is a calculator for the IPv4/v6 addresses
        networkmanager-openvpn
        networkmanagerapplet # network manager applet

        # misc file manipulator
        file
        which
        tree
        lshw
        trash-cli # trash folder manipulator
        duf # disk viewer
        dust
        dua
        navi

        # misc
        cowsay
        lolcat
        fortune-kind
        graphviz
        yt-dlp
        rich-cli
        comma

        # misc ui
        kdePackages.okular # pdf viewer
        catppuccin-gtk # gtk theme
        pavucontrol # volume control
        qimgv # img viewer
        inkscape # svg manipulator
        qalculate-gtk # calculator
        # simplescreenrecorder # screen recorder
        screenkey # display keys pressed on screen
        skippy-xd

        imagemagick
        ghostscript
        xclip
        maim
        redshift
        syncthing

        # messenger app
        # caprine

        # yazi
        atool
        xlsx2csv
        # mupdf
        mupdf-headless
        pandoc
        exiftool
        # ueberzugpp
        mediainfo

        # # web
        # nginx
        # php
        # mysql84

        # apps
        # xfce.thunar
        # xfce.thunar-volman
        # xfce.thunar-vcs-plugin
        # xfce.thunar-media-tags-plugin
        # xfce.thunar-archive-plugin
        qt6.qtwayland
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        gvfs
        obsidian
        vesktop
        zotero
        telegram-desktop
        # wpsoffice
        libreoffice-qt6-fresh
        # zed-editor
        # microsoft-edge
        chromium
        # rnote # note taker
        qbittorrent-enhanced
        pkg-config
        teams-for-linux
        # rustdesk-flutter
        anydesk
        # zen-browser
        inputs.zen-browser.packages."${system}".generic
        anki-bin
        jetbrains.idea-ultimate
        code-cursor

        # nix related
        #
        # it provides the command `nom` works just like `nix`
        # with more details log output
        nix-output-monitor
        nix-prefetch-github

        # monitoring
        btop  # replacement of htop/nmon
        # htop
        iotop # io monitoring
        iftop # network monitoring
        # nvitop
        nvtopPackages.full

        # system call monitoring
        strace # system call monitoring
        ltrace # library call monitoring
        lsof # list open files

        # system tools
        ethtool
        pciutils # lspci
        usbutils # lsusb
        # toybox

        # libs
        xorg.xhost
        clang-tools
    ];

    # graphics
    nixGL.vulkan.enable = true;
    programs = {
        jq.enable = true; # A lightweight and flexible command-line JSON processor
        feh.enable = true; # image viewer
        cava.enable = true; # audio visualizer
        zoxide.enable = true;

        # java
        java = {
            enable = true;
            package = pkgs.jdk23;
        };

        # nix-index
        command-not-found.enable = false; # command not found handler
        nix-index = {
            enable = true;
            enableFishIntegration = true;
        };
    };

    services = {
        network-manager-applet.enable = true;
        blueman-applet.enable = true;
        easyeffects.enable = true; # audio effects
        copyq.enable = true;
    };
}
