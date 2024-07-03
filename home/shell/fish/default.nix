{ config, pkgs, ... }:
{
    programs.fish = {
        enable = true;

        shellInit = ''
            bash ~/.profile
            source ~/.conda/etc/fish/conf.d/conda.fish

            # for bluetooth, it will crash without this
            dbus-update-activation-environment DISPLAY

            # fish_add_path /home/blackwhite/bin

            eval (direnv hook fish)

            eval (ssh-agent -c) &>/dev/null

            function fish_greeting
                echo hiiiii (set_color 00C8FF -o)$USER (set_color F9E2AF)@ (set_color FF006A)$hostname(set_color normal)(set_color white)!
            end
            # fastfetch

            function yy
                set tmp (mktemp -t "yazi-cwd.XXXXXX")
                yazi $argv --cwd-file="$tmp"
                if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                    cd -- "$cwd"
                end
                rm -f -- "$tmp"
            end
        '';

        shellAliases = {
            update = "sudo nixos-rebuild switch";
            y = "yy"; # yazi function
            v = "nvim";
            c = "code";
            b = "bat";
            d = "dua i";

            g = "git";
            lg = "lazygit";
            gaa = "git add .";
            gcm = "git commit -m";
            gcma = "git commit -ma";
            gp = "git push";
            gs = "git status";

            venv_create = "python -m venv venv";
            venv_activate = "source venv/bin/activate.fish";

            s = "kitten ssh";
            ca = "conda activate";
            cs = "conda-shell -c fish";
            clean_cache = "~/bin/clean_cache";
        };
    };

    xdg.configFile."fish/fish_variables" = {
        source = ./fish_variables;
    };
}