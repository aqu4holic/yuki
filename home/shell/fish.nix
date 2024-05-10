{ pkgs, ... }:

# fish

let
    font = "JetBrainsMono Nerd Font";
in
{
    programs.fish = {
        enable = true;
        
        interactiveShellInit = ''
            set -g fish_greeting "hiiii blackwhite!" # Disable greeting;
            neofetch
        '';
    };
}