{ config, pkgs, ... }:
{
    catppuccin = {
        enable = false;
        flavor = "mocha";
        accent = "maroon";

        kvantum = {
            enable = true;
            flavor = "mocha";
            accent = "maroon";
        };

        gtk = {
            enable = true;
            flavor = "mocha";
            accent = "maroon";
            size = "standard";
            tweaks = [ "rimless" ];
        };
    };
}
