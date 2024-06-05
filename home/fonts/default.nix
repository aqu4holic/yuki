{ config, pkgs, libs, ... }:
{
    home.packages = with pkgs; [
        (
            pkgs.nerdfonts.override {
                fonts = [
                    "FiraCode"
                    "JetBrainsMono"
                    "Iosevka"
                    "MPlus"
                ];
            }
        )
    ];

    fonts.fontconfig.enable = true;
}