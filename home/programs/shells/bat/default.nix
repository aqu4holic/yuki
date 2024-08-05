{ pkgs, config, ... }:
{
    programs.bat = {
        enable = true;

        catppuccin.enable = true;
    };

    # bat cache --build
    xdg.configFile."bat/themes" = {
        source = ./themes;

        recursive = true;
    };
}