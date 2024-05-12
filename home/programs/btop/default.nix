{ pkgs, config, ... }:
{
    programs.btop = {
        enable = true; # replacement of htop/nmon
    };

    home.file.".config/btop/btop.conf" = {
        source = ./btop.conf;
    };
}