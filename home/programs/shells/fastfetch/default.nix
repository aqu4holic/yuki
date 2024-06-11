{ pkgs, config, ... }:
{
    xdg.configFile."fastfetch/config.jsonc" = {
        source = ./config.jsonc;

        # recursive = true;
    };
}