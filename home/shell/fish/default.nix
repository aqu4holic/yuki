{ config, pkgs, ... }:
{
    programs.fish = {
        enable = true;

        shellInit = ''
            # bash ~/.profile

            if status --is-login
                if test -z "$DISPLAY" -a $XDG_VTNR = 1
                    exec startx -- -keeptty
                end
            end

            # fish_add_path /home/blackwhite/bin

            eval (direnv hook fish)

            eval (ssh-agent -c) &>/dev/null

            # function fish_greeting
            #     echo hiiiii (set_color 00C8FF -o)$USER (set_color F9E2AF)@ (set_color FF006A)$hostname(set_color normal)(set_color white)!
            # end
            set fish_greeting
            # # fastfetch

            function yy
                set tmp (mktemp -t "yazi-cwd.XXXXXX")
                yazi $argv --cwd-file="$tmp"
                if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                    cd -- "$cwd"
                end
                rm -f -- "$tmp"
            end
        '';

        shellInitLast = ''
            # for bluetooth, it will crash without this
            dbus-update-activation-environment DISPLAY
            source ~/.conda/etc/fish/conf.d/conda.fish

            function starship_transient_prompt_func
                starship module directory
                starship module character
            end
            function starship_transient_rprompt_func
                starship module cmd_duration
            end
            starship init fish | source
            enable_transience
        '';

        shellAliases = {
            update = "sudo nixos-rebuild switch";

            y = "yy"; # yazi function
            v = "nvim";
            c = "code";
            b = "bat";
            d = "dua i";
            cls = "clear";

            g = "git";
            lg = "lazygit";
            gaa = "git add .";
            gcm = "git commit -m";
            gcma = "git commit -ma";
            gp = "git push";
            gs = "git status";

            gdb = ''gdb -q -ex "set verbose off" -ex "set complaints 0" -ex "set confirm off" -ex "set exec-done-display off"'';

            vc = "python3 -m venv venv";
            va = "source venv/bin/activate.fish";
            vca = "python3 -m venv venv && source venv/bin/activate.fish";
            # venv_fix = ''
            #     nix shell github:GuillaumeDesforges/fix-python
            #     fix-python --venv venv
            #     exit
            # '';

            ccv = "conda create --name venv";
            cav = "conda activate venv";
            ccav = "conda create --name venv && conda activate venv";
            ccn = "conda create --name";
            cac = "conda activate";
            cda = "conda deactivate";
            cfa = "conda env create -f environment.yaml";
            crm = "conda remove --all -n";

            s = "kitten ssh";
            rs = "rsync -avP";
            cs = "conda-shell -c fish";

            # screen
            sr = "screen -r";
            ss = "screen -S";
            sls = "screen -ls";
            sd = "screen -d";
        };
    };

    xdg.configFile."fish/fish_variables" = {
        source = ./fish_variables;
    };
}
