{ config, pkgs, ... }:
{
    xsession = {
        windowManager = {
            bspwm = {
                enable = true;

                startupPrograms = [
                    "picom"
                    "polybar -q bar"
                ];
            };
        };
    };
}