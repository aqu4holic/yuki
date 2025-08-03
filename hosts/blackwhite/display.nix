{ inputs, config, pkgs, lib, ... }:
{
    # Enable the X11 windowing system.
    services = {
        xserver = {
            enable = true;

            windowManager.bspwm = {
                enable = true;
            };

            displayManager = {
                startx = {
                    enable = true;
                };
            };
        };

        # displayManager = {
        #     defaultSession = "none+bspwm";
        # };
    };

    # Enable the Hyprland compositor.
    programs = {
        hyprland = {
            enable = true;
            # withUWSM = true;
            xwayland.enable = true;
        };

        hyprlock = {
            enable = true;
        };

        waybar = {
            enable = true;
        };

    };
}
