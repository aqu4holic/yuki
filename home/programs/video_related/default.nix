{ config, pkgs, ... }:
{
    programs.mpv = {
        enable = true;
    };

    programs.obs-studio = {
        enable = true;
        package = (pkgs.obs-studio.override {
            cudaSupport = true;
        });
    };

    # xdg.configFile."mpv" = {
    #     source = ./config;

    #     recursive = true;
    # };
}