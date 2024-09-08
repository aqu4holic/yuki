{ pkgs, config, ... }:
{
    programs.bat = {
        enable = true;

        catppuccin.enable = true;

        config = {
            pager = "less -RF";
            style = "plain";
        };
    };

    # bat cache --build
    xdg.configFile."bat/themes" = {
        source = ./themes;

        recursive = true;
    };
}
