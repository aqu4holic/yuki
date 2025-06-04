{ config, pkgs, libs, ... }:
{
    home.packages = with pkgs; [
        mangohud
        protonup
        # protontricks
        bottles # gotta install w flatpak
    ];

    home.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
}
