{ config, pkgs, ... }:
{
    imports = [
        ./plugins/official
    ];

    programs.yazi = {
        enable = true;

        plugins = with pkgs; {
            nbpreview = callPackage ./plugins/nbpreview-yazi.nix {};
            mediainfo = callPackage ./plugins/mediainfo-yazi.nix {};
            relative-motions = callPackage ./plugins/relative-motions-yazi.nix {};
            # first-non-directory = callPackage ./plugins/first-non-directory-yazi.nix {};
            yamb = callPackage ./plugins/yamb-yazi.nix {};
            compress = callPackage ./plugins/compress-yazi.nix {};
            # rsync = callPackage ./plugins/rsync-yazi.nix {};
            what-size = callPackage ./plugins/what-size-yazi.nix {};
            restore = callPackage ./plugins/restore-yazi.nix {};
            open-with-cmd = callPackage ./plugins/open-with-cmd-yazi.nix {};

            # eza-preview = callPackage ./plugins/eza-preview-yazi.nix {};
            eza-preview = ./plugins/eza-preview.yazi;
            smart-enter = ./plugins/smart-enter.yazi;
            smart-paste = ./plugins/smart-paste.yazi;
            smart-tab = ./plugins/smart-tab.yazi;
            arrow = ./plugins/arrow.yazi;
            parent-arrow = ./plugins/parent-arrow.yazi;
        };

        # flavors = with pkgs; {
        #     catppuccin-mocha = callPackage ./flavors/catppuccin-mocha-yazi.nix {};
        # };
    };

    xdg.configFile."yazi" = {
        source = ./config;

        recursive = true;
    };
}