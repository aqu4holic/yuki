{ config, pkgs, lib, ... }:
{
    home.file.".local/share/icons/MoreWaita" = {
        source = "${pkgs.morewaita-icon-theme}/share/icons";
    };
}