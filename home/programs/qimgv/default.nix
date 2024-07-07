{ config, pkgs, ... }:
{
    xdg.configFile."qimgv" = {
        source = ./config;

        recursive = true;
    };
}