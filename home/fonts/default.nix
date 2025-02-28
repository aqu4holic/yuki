{ config, pkgs, libs, ... }:
{
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
        # normal fonts
        times-newer-roman

        # icon fonts
        material-design-icons
        material-icons

        # (
        #     pkgs.nerdfonts.override {
        #         fonts = [
        #             "FiraCode"
        #             "JetBrainsMono"
        #             "Iosevka"
        #             # "MPlus"
        #         ];
        #     }
        # )
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        # "MPlus"

    ];

    # run `fc-cache -frv`
    home.file.".local/share/fonts" = {
        source = ./custom_fonts;
        recursive = true;
    };
}
