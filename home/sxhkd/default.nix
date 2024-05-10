{ config, pkgs, ... }:
{
    services.sxhkd = {
        enable = true;

        keybindings = {
            "super + Return" = "kitty";
            "super + Tab" = "bspc desktop -last f";
            "super + f" = "bspc node -t '~fullscreen'";
        };
    };
}