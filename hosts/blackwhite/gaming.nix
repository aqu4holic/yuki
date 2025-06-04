{ config, pkgs, libs, ... }:
{
    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
}
