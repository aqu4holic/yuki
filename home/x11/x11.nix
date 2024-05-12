{ config, pkgs, ... }:
{
    # set cursor size and dpi for 4k monitor
    xresources.properties = {
        "Xcursor.size" = 16;
        "Xft.dpi" = 192;
    };

    home.file.".xinitrc" = {
        source = ./.xinitrc;
    };
}