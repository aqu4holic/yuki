{ config, pkgs, ... }:
{
    services.sxhkd = {
        enable = true;

        keybindings = {
            "super + Return" = "kitty";
            "super + Tab" = "bspc node -last f";
            "super + f" = "bspc node -t '~fullscreen'";
            # "super + Space" = 
        };
    };
}