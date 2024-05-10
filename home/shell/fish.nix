{ pkgs, config, ... }:

# fish

let
    font = "JetBrainsMono Nerd Font";
in
{
    programs.fish = {
        enable = true;
        
        # shellInit = ''
        #     set -g fish_greeting "hiiii blackwhite!" # Disable greeting;
        #     # fastfetch
        # '';
    };

    home.file.".config/fish" = {
        enable = true;

        source = ./fish;

        recursive = true;
    };
}