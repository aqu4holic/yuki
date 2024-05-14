{ config, pkgs, xdg, lib, ... }:
{
    services.picom = {
        enable = true;

        # package = {
        #     src = pkgs.fetchFromGithub {

        #     }
        # }
    };

    # home.file.".config/picom/picom.conf" = {
    #     source = ./picom.conf;
    # };

    xdg.configFile."picom/picom.conf" = {
        source = lib.mkForce ./picom.conf;
    };

    xresources.properties = {
        "Xcursor.size" = 16;
        "Xft.dpi" = 192;
    };
}
