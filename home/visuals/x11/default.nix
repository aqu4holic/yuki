{ config, pkgs, ... }:
{
    imports = [
        ./bspwm_sxhkd
        ./picom
        ./rofi
        ./eww
        ./polybar

    ];
    home.file.".xinitrc" = {
        source = ../../../assets/bin/.xinitrc;
    };
}
