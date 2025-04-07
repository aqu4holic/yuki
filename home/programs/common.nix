{ inputs, config, pkgs, libs, ... }:

{
    imports = [
        ./python
    ];

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
        # here is some command line tools i use frequently
        # feel free to add your own or remove some of them

        (
            writeShellScriptBin "clean_cache" ''
                nix-collect-garbage --delete-old
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
        jq # A lightweight and flexible command-line JSON processor
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

        # misc file manipulator
        file
        which
        tree
        lshw
        trash-cli # trash folder manipulator
        duf # disk viewer
        dua
        navi

        # misc
        cowsay
        lolcat
        fortune-kind
        graphviz
        yt-dlp

        # misc ui
        kdePackages.okular # pdf viewer
        catppuccin-gtk # gtk theme
        pavucontrol # volume control
        qimgv # img viewer
        inkscape # svg manipulator
        qalculate-gtk # calculator
        # simplescreenrecorder # screen recorder
        obs-studio # screen recorder
        screenkey # display keys pressed on screen
        skippy-xd

        copyq
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
        obsidian
        vesktop
        zotero
        telegram-desktop
        mpv
        # wpsoffice
        libreoffice-qt6-fresh
        zed-editor
        # microsoft-edge
        chromium
        # rnote # note taker
        qbittorrent-enhanced
        pkg-config
        teams-for-linux
        rustdesk-flutter
        anydesk
        # zen-browser
        inputs.zen-browser.packages."${system}".generic
        anki-bin

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
        nvtopPackages.nvidia

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

    programs = {
        jq.enable = true; # A lightweight and flexible command-line JSON processor
        feh.enable = true; # image viewer
        zoxide.enable = true;

        # java
        java = {
            enable = true;
            package = pkgs.jdk23;
        };
    };

    services = {
        network-manager-applet.enable = true;
        copyq.enable = true;

        gnome-keyring = {
            enable = true;

        };
    };
}
