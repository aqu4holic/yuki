{ config, pkgs, lib, ... }:
{
    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;

        windowManager.bspwm = {
            enable = true;
        };

        displayManager = {
            defaultSession = "none+bspwm";

            startx = {
                enable = true;
            };
        };
    };
}
