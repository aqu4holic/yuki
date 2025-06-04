{ pkgs, config, ... }:
{
    programs.bat = {
        enable = true;

        config = {
            pager = "less -RF";
            style = "plain";
        };
    };

    catppuccin.bat.enable = true;

    # bat cache --build
    xdg.configFile."bat/themes" = {
        source = ./themes;

        recursive = true;
    };
}
