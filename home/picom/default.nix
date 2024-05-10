{ config, pkgs, ... }:
{
    services.picom = {
        enable = true;
    };

    home.file.".config/picom/picom.conf" = {
        source = ./picom.conf
    };
}