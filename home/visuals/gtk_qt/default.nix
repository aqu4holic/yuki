{ config, pkgs, ... }:
{
    gtk = {
        enable = true;

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

        platformTheme.name = "kvantum";

        style.name = "kvantum";
    };
}
