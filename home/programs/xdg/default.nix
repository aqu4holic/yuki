{ config, xdg, pkgs, ... }:
{
    xdg = {
        cacheHome = config.home.homeDirectory + "/.local/cache";
        enable = true;

        userDirs = {
            enable = false;
            createDirectories = false;
        };

        portal = {
            enable = true;
            xdgOpenUsePortal = false;

            extraPortals = with pkgs; [
                xdg-desktop-portal
                xdg-desktop-portal-gtk
                gnome-keyring
            ];

            config = {
                common = {
                    default = [ "gtk" ];
                    "org.freedesktop.impl.portal.Secret" = [
                        "gnome-keyring"
                    ];
                };
            };
        };

        # mime
        # mime.enable = true;
        # mimeApps = {
        #     enable = true;
        #     assosiations.added =
        # };
        mimeApps.defaultApplications = {
            "image/png" = [
                "qimgv.desktop"
            ];
            "image/jpeg" = [
                "qimgv.desktop"
            ];
            "image/jpg" = [
                "qimgv.desktop"
            ];
        };
    };


    # home.sessionVariables = {
    #     XDG_CURRENT_DESKTOP = "GNOME";
    # };

    # xdg.configFile."mimeapps.list" = {
    #     source = ./mimeapps.list;
    #     recursive = true;
    # };
}
