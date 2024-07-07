{ config, pkgs, libs, ... }:
{
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        # icon fonts
        material-design-icons
        material-icons

        # normal fonts

        (
            pkgs.nerdfonts.override {
                fonts = [
                    "FiraCode"
                    "JetBrainsMono"
                    "Iosevka"
                    # "MPlus"
                ];
            }
        )
    ];

    # run `fc-cache -frv`
    home.file.".local/share/fonts" = {
        source = ./custom_fonts;
        recursive = true;
    };
}