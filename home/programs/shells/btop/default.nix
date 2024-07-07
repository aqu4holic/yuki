{ pkgs, config, ... }:
{
    programs.btop = {
        enable = true; # replacement of htop/nmon

        settings = {
            color_theme = "adapta";
            theme_background = true;
            truecolor = true;
            vim_keys = true;
            update_ms = 1000;
        };
    };
}