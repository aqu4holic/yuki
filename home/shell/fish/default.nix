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

            function bind_bang
                switch (commandline --current-token)[-1]
                case "!"
                    # Without the `--`, the functionality can break when completing
                    # flags used in the history (since, in certain edge cases
                    # `commandline` will assume that *it* should try to interpret
                    # the flag)
                    commandline --current-token -- $history[1]
                    commandline --function repaint
                case "*"
                    commandline --insert !
                end
            end

            function bind_dollar
                switch (commandline --current-token)[-1]
                # This case lets us still type a literal `!$` if we need to (by
                # typing `!\$`). Probably overkill.
                case "*!\\"
                    # Without the `--`, the functionality can break when completing
                    # flags used in the history (since, in certain edge cases
                    # `commandline` will assume that *it* should try to interpret
                    # the flag)
                    commandline --current-token -- (echo -ns (commandline --current-token)[-1] | head -c '-1')
                    commandline --insert '$'
                case "!"
                    commandline --current-token ""
                    commandline --function history-token-search-backward


                # Main difference from referenced version is this `*!` case
                # =========================================================
                #
                # If the `!$` is preceded by any text, search backward for tokens
                # that contain that text as a substring. E.g., if we'd previously
                # run
                #
                #   git checkout -b a_feature_branch
                #   git checkout master
                #
                # then the `fea!$` in the following would be replaced with
                # `a_feature_branch`
                #
                #   git branch -d fea!$
                #
                # and our command line would look like
                #
                #   git branch -d a_feature_branch
                #
                case "*!"
                    # Without the `--`, the functionality can break when completing
                    # flags used in the history (since, in certain edge cases
                    # `commandline` will assume that *it* should try to interpret
                    # the flag)
                    commandline --current-token -- (echo -ns (commandline --current-token)[-1] | head -c '-1')
                    commandline --function history-token-search-backward
                case "*"
                    commandline --insert '$'
                end
            end

            function fish_user_key_bindings
                bind ! bind_bang
                bind '$' bind_dollar
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

            gdb = ''gdb -q -ex "set verbose off" -ex "set complaints 0" -ex "set confirm off" -ex "set exec-done-display off"'';

            joern = "~/bin/joern/joern-cli/joern";
            joern-cpg2scpg = "~/bin/joern/joern-cli/joern-cpg2scpg";
            joern-export = "~/bin/joern/joern-cli/joern-export";
            joern-flow = "~/bin/joern/joern-cli/joern-flow";
            joern-parse = "~/bin/joern/joern-cli/joern-parse";
            joern-scan = "~/bin/joern/joern-cli/joern-scan";
            joern-slice = "~/bin/joern/joern-cli/joern-slice";
            joern-vectors = "~/bin/joern/joern-cli/joern-vectors";

            venv_create = "python -m venv venv";
            venv_activate = "source venv/bin/activate.fish";

            s = "kitten ssh";
            ca = "conda activate";
            cs = "conda-shell -c fish";
        };
    };

    xdg.configFile."fish/fish_variables" = {
        source = ./fish_variables;
    };
}
