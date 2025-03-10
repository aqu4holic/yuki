{ config, pkgs, ... }:
{
    programs.yazi = {
        enable = true;

        plugins = with pkgs; {
            chmod = callPackage ./chmod-yazi.nix {};
            diff = callPackage ./diff-yazi.nix {};
            git = callPackage ./git-yazi.nix {};
            full-border = callPackage ./full-border-yazi.nix {};
            smart-filter = callPackage ./smart-filter-yazi.nix {};
            toggle-pane = callPackage ./toggle-pane-yazi.nix {};
        };
    };
}