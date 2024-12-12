{ pkgs, config, ... }:
{
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = {
        enable = true;
    };

    xdg.configFile."starship.toml" = {
        source = ./minimal_starship.toml;

        recursive = true;
    };
}
