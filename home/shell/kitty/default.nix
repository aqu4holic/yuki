{ pkgs, lib, ... }:
{
    programs.kitty = {
        enable = true;

        # enable integration
        shellIntegration.enableFishIntegration = true;
    };

    xdg.configFile."kitty" = {
        source = ./config;

        recursive = true;
    };
}
