{ config, pkgs, ... }:
{
    programs.fish = {
        enable = true;

        shellInit = ''
            bash ~/.profile

            # set CLUTTER_IM_MODULE ibus
            # set GLFW_IM_MODULE ibus
            # set QT4_IM_MODULE ibus

            eval (ssh-agent -c) &>/dev/null

            function fish_greeting
                echo hiiiii (set_color 00C8FF)$USER (set_color white)@ (set_color FF006A)$hostname(set_color white)!
            end
            # fastfetch
        '';

        shellAliases = {
            update = "sudo nixos-rebuild switch";
            r = "joshuto";
            v = "nvim";
            g = "git";
            c = "code";
            clean_cache = "~/bin/clean_cache";
        };
    };
}