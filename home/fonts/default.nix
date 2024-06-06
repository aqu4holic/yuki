{ config, pkgs, libs, ... }:
{
    home.packages = with pkgs; [
        # icon fonts
        material-design-icons
        material-icons

        papirus-icon-theme

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