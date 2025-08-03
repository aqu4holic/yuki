{ config, xdg, pkgs, ... }:
{
    xdg = {
        # cacheHome = config.home.homeDirectory + "/.local/cache";
        enable = true;

        userDirs = {
            enable = false;
            createDirectories = false;
        };

        portal = {
            enable = true;
            xdgOpenUsePortal = true;

            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
                # (let
                #     gtkPortal = xdg-desktop-portal-gtk.overrideAttrs (prevAttrs: {
                #         buildInputs = builtins.filter
                #             (x: x != gnome-desktop && x != gnome-settings-daemon)
                #             prevAttrs.buildInputs;
                #         mesonFlags = [ "-Dwallpaper=disabled" ];
                #     });
                # in gtkPortal)
                # kdePackages.xdg-desktop-portal-kde
                gnome-keyring
            ];

            config = {
                hyprland = {
                    default = [ "hyprland" "gtk" ];
                    "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
                    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
                };

                # common = {
                #     default = [ "hyprland" "gtk" ];
                #     "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
                #     "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
                # };
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


    home.sessionVariables = {
        GTK_USE_PORTAL = "1";
    };

    # xdg.configFile."mimeapps.list" = {
    #     source = ./mimeapps.list;
    #     recursive = true;
    # };
}
