{ config, pkgs, ... }:
{
    programs.yazi = {
        enable = true;
    };

    xdg.configFile."yazi" = {
        source = ./config;

        recursive = true;
    };
}