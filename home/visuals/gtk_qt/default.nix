{ config, pkgs, ... }:
{
    gtk = {
        enable = true;
        catppuccin = {
            enable = true;
            flavor = "mocha";
            accent = "maroon";
            size = "standard";
            tweaks = [ "rimless" ];
        };

        font = {
            name = "MonoLisa";
            size = 13;
        };

        iconTheme = {
            name = "Papirus";
            package = pkgs.papirus-icon-theme;
        };
    };

    qt = {
        enable = true;

        platformTheme.name = "gtk3";

        style.catppuccin = {
            enable = true;
            apply = true;
            flavor = "mocha";
            accent = "maroon";
        };
    };
}