{ pkgs, config, ... }:

# fish

let
    font = "JetBrainsMono Nerd Font";
in
{
    programs.fish = {
        enable = true;
        
        shellInit = ''
            function fish_greeting
                echo hiiiii (set_color 00C8FF)$USER (set_color white)@ (set_color FF006A)$hostname(set_color white)!
            end
            # fastfetch
        '';
    };
}