{ config, pkgs, ... }:
{
    programs.yazi = {
        enable = true;

        plugins = with pkgs; {
            nbpreview = callPackage ./plugins/nbpreview-yazi.nix {};
            # first-non-directory = callPackage ./plugins/first-non-directory-yazi.nix {};
            yamb = callPackage ./plugins/yamb-yazi.nix {};
            compress = callPackage ./plugins/compress-yazi.nix {};
            # rsync = callPackage ./plugins/rsync-yazi.nix {};
            what-size = callPackage ./plugins/what-size-yazi.nix {};
            open-with-cmd = callPackage ./plugins/open-with-cmd-yazi.nix {};

            # eza-preview = callPackage ./plugins/eza-preview-yazi.nix {};
            eza-preview = ./plugins/eza-preview.yazi;
            smart-paste = ./plugins/smart-paste.yazi;
            smart-tab = ./plugins/smart-tab.yazi;
            arrow = ./plugins/arrow.yazi;
            parent-arrow = ./plugins/parent-arrow.yazi;

            # official
            git = yaziPlugins.git;
            diff = yaziPlugins.diff;
            chmod = yaziPlugins.chmod;
            full-border = yaziPlugins.full-border;
            smart-enter = yaziPlugins.smart-enter;
            smart-filter = yaziPlugins.smart-filter;

            sudo = yaziPlugins.sudo;

            relative-motions = yaziPlugins.relative-motions;
            mediainfo = yaziPlugins.mediainfo;
            mount = yaziPlugins.mount;
            rich-preview = yaziPlugins.rich-preview;
            restore = yaziPlugins.restore;
        };
    };

    catppuccin.yazi = {
        enable = true;
        flavor = "mocha";
        accent = "maroon";
    };

    xdg.configFile."yazi" = {
        source = ./config;

        recursive = true;
    };
}
