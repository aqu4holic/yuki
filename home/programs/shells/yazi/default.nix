{ config, pkgs, ... }:
{
    programs.yazi = {
        enable = true;

        plugins = with pkgs; {
            # glow = callPackage ./plugins/glow-yazi.nix {};
            eza-preview = callPackage ./plugins/eza-preview-yazi.nix {};
            nbpreview = callPackage ./plugins/nbpreview-yazi.nix {};
            # hexyl = callPackage ./plugins/hexyl-yazi.nix {};
            # miller = callPackage ./plugins/miller-yazi.nix {};
            mediainfo = callPackage ./plugins/mediainfo-yazi.nix {};
            relative-motions = callPackage ./plugins/relative-motions-yazi.nix {};
            first-non-directory = callPackage ./plugins/first-non-directory-yazi.nix {};
            chmod = callPackage ./plugins/chmod-yazi.nix {};
            diff = callPackage ./plugins/diff-yazi.nix {};
            git = callPackage ./plugins/git-yazi.nix {};
            full-border = callPackage ./plugins/full-border-yazi.nix {};
            max-preview = callPackage ./plugins/max-preview-yazi.nix {};
            smart-filter = callPackage ./plugins/smart-filter-yazi.nix {};
            yamb = callPackage ./plugins/yamb-yazi.nix {};
            compress = callPackage ./plugins/compress-yazi.nix {};
            # rsync = callPackage ./plugins/rsync-yazi.nix {};
            what-size = callPackage ./plugins/what-size-yazi.nix {};
            lazygit = callPackage ./plugins/lazygit-yazi.nix {};
            restore = callPackage ./plugins/restore-yazi.nix {};
            open-with-cmd = callPackage ./plugins/open-with-cmd-yazi.nix {};

            smart-enter = ./plugins/smart-enter.yazi;
            smart-paste = ./plugins/smart-paste.yazi;
            smart-tab = ./plugins/parent-arrow.yazi;
            arrow = ./plugins/arrow.yazi;
            parent-arrow = ./plugins/parent-arrow.yazi;
        };

        flavors = with pkgs; {
            catppuccin-mocha = callPackage ./flavors/catppuccin-mocha-yazi.nix {};
        };
    };

    xdg.configFile."yazi" = {
        source = ./config;

        recursive = true;
    };
}
