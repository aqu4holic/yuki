{ config, pkgs, ... }:
{
    programs.fish = {
        enable = true;

        shellInit = ''
            bash ~/.profile
            source ~/.conda/etc/fish/conf.d/conda.fish

            # for bluetooth, it will crash without this
            dbus-update-activation-environment DISPLAY

            eval (direnv hook fish)

            eval (ssh-agent -c) &>/dev/null

            function fish_greeting
                echo hiiiii (set_color 00C8FF -o)$USER (set_color F9E2AF)@ (set_color FF006A)$hostname(set_color normal)(set_color white)!
            end
            # fastfetch

            function joshuto
                set ID (random)
                set OUTPUT_FILE /tmp/$USER/joshuto-cwd-$ID
                mkdir -p /tmp/$USER

                env joshuto --output-file "$OUTPUT_FILE" $argv
                set exit_code $status

                switch $exit_code
                    case 0
                        # Regular exit, do nothing
                    case 101
                        set JOSHUTO_CWD (cat "$OUTPUT_FILE")
                        cd $JOSHUTO_CWD
                    case 102
                        # Output selected files, do nothing
                    case '*'
                        echo "Exit code: $exit_code"
                end
            end
        '';

        shellAliases = {
            update = "sudo nixos-rebuild switch";
            j = "joshuto";
            v = "nvim";
            c = "code";
            g = "git";
            venv_activate = "source venv/bin/activate.fish";
            s = "kitten ssh";
            gaa = "git add .";
            gcm = "git commit -m";
            gcma = "git commit -ma";
            gp = "git push";
            ca = "conda activate";
            cs = "conda-shell -c fish";
            clean_cache = "~/bin/clean_cache";
        };
    };

    xdg.configFile."fish/fish_variables" = {
        source = ./fish_variables;
    };
}