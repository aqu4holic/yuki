{ config, inputs, pkgs, xdg, lib, ... }:
{
    services.picom = {
        enable = true;

        package = pkgs.fetchFromGitHub {
            owner = "pijulius";
            repo = "picom";
            rev = "e7b14886ae644aaa657383f7c4f44be7797fd5f6";
            sha256 = "YQVp5HicO+jbvCYSY+hjDTnXCU6aS3aCvbux6NFcJ/Y=";
        };
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
