{ pkgs, config, ... }:
{
    programs.bat = {
        enable = true;

        config = {
            theme = "Catppuccin Mocha";
            paging = "never";
            style = "plain";
        };
    };

    # bat cache --build
    xdg.configFile."bat/themes" = {
        source = ./themes;

        recursive = true;
    };
}