{ config, xdg, pkgs, ... }:
{
    systemd.user.services.xdg-desktop-portal-gtk = {
        wantedBy = [ "xdg-desktop-portal.service" ];
        before = [ "xdg-desktop-portal.service" ];
    };

    programs.ssh = {
        startAgent = true;
    };
}
