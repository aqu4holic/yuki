{ config, pkgs, ... }:

{
    imports = [
        ./programs
        ./shell
        ./bspwm
        ./sxhkd
        # ./rofi
        ./polybar
        # ./picom
    ];

    # link the configuration file in current directory to the specified location in home directory
    # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

    # link all files in `./scripts` to `~/.config/i3/scripts`
    # home.file.".config/i3/scripts" = {
    #   source = ./scripts;
    #   recursive = true;   # link recursively
    #   executable = true;  # make all files executable
    # };

    # encode the file content in nix configuration file directly
    # home.file.".xxx".text = ''
    #     xxx
    # '';

    home = {
        username = "blackwhite";
        homeDirectory = "/home/blackwhite";

        # This value determines the home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update home Manager without changing this value. See
        # the home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "23.11";
    };

    # set cursor size and dpi for 4k monitor
    xresources.properties = {
        "Xcursor.size" = 16;
        "Xft.dpi" = 172;
    };

    # Let home Manager install and manage itself.
    # programs.home-manager.enable = true;
}