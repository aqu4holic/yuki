{ config, pkgs, libs, ... }:
{
    services.flameshot = {
        enable = true;
    };

    xdg.configFile."flameshot/flameshot.ini" = {
        source = ./flameshot.ini;
    };
}
