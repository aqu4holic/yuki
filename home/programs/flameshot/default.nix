{ config, pkgs, libs, ... }:
{
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        flameshot
    ];

    xdg.configFile."flameshot/flameshot.ini" = {
        source = ./flameshot.ini;
    };
}
