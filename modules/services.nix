{ config, xdg, pkgs, ... }:
{
    xdg = {
        portal = {
            enable = true;
            xdgOpenUsePortal = true;

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
    };

    systemd.user.services.xdg-desktop-portal-gtk = {
        wantedBy = [ "xdg-desktop-portal.service" ];
        before = [ "xdg-desktop-portal.service" ];
    };
}
