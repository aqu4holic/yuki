{ config, pkgs, xdg, lib, ... }:
{
    services.polybar = {
        enable = true;

        script = builtins.readFile ../../../bin/launch.sh;
    };

    xdg.configFile."polybar" = {
        source = ./.;

        recursive = true;
    };
}