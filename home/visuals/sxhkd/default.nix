{ config, pkgs, xdg, lib, ... }:
{
    services.sxhkd = {
        enable = true;

        extraConfig = builtins.readFile ./sxhkdrc;
    };

    # xdg.configFile."sxhkd/sxhkdrc" = {
    #     source = lib.mkForce ./sxhkdrc;
    # };
}