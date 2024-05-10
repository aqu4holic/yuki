{ pkgs, config, ... }:
{
    programs.btop = {
        enable = true;
    };

    home.file.".config/btop/btop.conf" = {
        source = ./btop.conf;
    };
}