{ config, pkgs, libs, ... }:
{
    home.packages = with pkgs; [
        skippy-xd
    ];

    xdg.configFile."skippy-xd/skippy-xd.rc" = {
        source = ./skippy-xd.rc;
    };
}
