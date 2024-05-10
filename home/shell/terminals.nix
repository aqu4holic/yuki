{ pkgs, ... }:

# terminals

let
    font = "JetBrainsMono Nerd Font";
in
{
    programs.kitty = {
        enable = true;
        settings = {
            # window.opacity = 0.95;
            # scrolling.history = 10000;
        };
    };
}