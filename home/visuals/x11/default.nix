{ config, pkgs, ... }:
{
    home.file.".xinitrc" = {
        source = ../../../bin/.xinitrc ;
    };
}