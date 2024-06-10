{ config, pkgs, libs, ... }:

{
    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
        # here is some command line tools I use frequently
        # feel free to add your own or remove some of them

        # archives
        zip
        xz
        unzip
        p7zip

        # utils
        ripgrep # recursively searches directories for a regex pattern
        jq # A lightweight and flexible command-line JSON processor
        yq-go # yaml processor https://github.com/mikefarah/yq
        eza # A modern replacement for ‘ls’
        fzf # A command-line fuzzy finder
        fd
        bat
        zoxide

        # networking tools
        mtr # A network diagnostic tool
        iperf
        dnsutils  # `dig` + `nslookup`
        ldns # replacement of `dig`, it provide the command `drill`
        aria2 # A lightweight multi-protocol & multi-source command-line download utility
        socat # replacement of openbsd-netcat
        nmap # A utility for network discovery and security auditing
        ipcalc  # it is a calculator for the IPv4/v6 addresses

        # misc
        file
        which
        tree
        gnused
        gnutar
        gawk
        zstd
        gnupg
        lshw
        trash-cli # trash folder manipulator
        dust # du but saner
        erdtree
        duf

        # misc
        cowsay
        lolcat
        fortune-kind
        # playerctl

        # misc ui
        kdePackages.spectacle # screenshot tool
        catppuccin-gtk # gtk theme
        pavucontrol # volume control
        pinta # img manipulator
        qimgv # img viewer
        inkscape # svg manipulator
        qalculate-gtk # calculator
        simplescreenrecorder # screen recorder
        screenkey # display keys pressed on screen

        copyq
        imagemagick
        xclip
        maim
        redshift
        syncthing

        # joshuto
        atool
        xlsx2csv
        unrar
        # mupdf
        mupdf-headless
        pandoc
        exiftool
        ueberzugpp

        # app
        obsidian
        vesktop
        zotero
        spotify
        telegram-desktop
        mpv
        # wpsoffice

        # nix related
        #
        # it provides the command `nom` works just like `nix`
        # with more details log output
        nix-output-monitor
        nix-prefetch-github

        # productivity
        hugo # static site generator
        glow # markdown previewer in terminal

        btop  # replacement of htop/nmon
        htop
        iotop # io monitoring
        iftop # network monitoring
        nvtopPackages.panthor

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
        conda
        xorg.xhost
    ];

    programs = {
        jq.enable = true; # A lightweight and flexible command-line JSON processor
        feh.enable = true; # image viewer
        zoxide.enable = true;
    };

    services = {
        network-manager-applet.enable = true;
        copyq.enable = true;
    };
}