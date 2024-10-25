{ config, xdg, ... }:
{
    xdg = {
        portal.config = {
            common = {
                default = "*";
            };
        };

        enable = true;
        cacheHome = config.home.homeDirectory + "/.local/cache";

        userDirs = {
            enable = false;
            createDirectories = false;
        };
    };
}
