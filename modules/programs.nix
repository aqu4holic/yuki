{ config, xdg, pkgs, ... }:
{
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
        # networkmanagerapplet

        # audio
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
        libsecret
        gcr

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

    programs.ssh = {
        startAgent = true;
    };

    # programs.nix-ld = {
    #     enable = true;
    #
    #     libraries = with pkgs; [
    #         zlib
    #         zstd
    #         stdenv.cc.cc
    #         stdenv.cc
    #         curl
    #         openssl
    #         attr
    #         libssh
    #         bzip2
    #         libxml2
    #         acl
    #         libsodium
    #         util-linux
    #         xz
    #         systemd
    #     ];
    # };

    programs = {
        dconf.enable = true;
        adb.enable = true;
    };
    security.pam.services.i3lock.enable = true;
}
