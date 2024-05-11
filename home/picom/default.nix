{ config, pkgs, ... }:
{
    home.file.".config/picom/picom.conf".source = ./picom.conf;

    services.picom = {
        enable = true;
    };

    # home.file.".config/picom/picom.conf" = {
    #     source = ./picom.conf;
    # };

    xresources.properties = {
        "Xcursor.size" = 16;
        "Xft.dpi" = 192;
    };
}