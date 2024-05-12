{ config, pkgs, ... }:
{
    xsession = {
        windowManager = {
            bspwm = {
                enable = true;

                extraConfigEarly = builtins.readFile ./bspwmrc;
            };
        };
    };
}