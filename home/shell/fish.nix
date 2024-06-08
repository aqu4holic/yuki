{ config, pkgs, ... }:
{
    programs.fish = {
        enable = true;

        shellInit = ''
            bash ~/.profile

            eval (ssh-agent -c) &>/dev/null

            function fish_greeting
                echo hiiiii (set_color 00C8FF)$USER (set_color white)@ (set_color FF006A)$hostname(set_color white)!
            end
            # fastfetch

            # function joshuto
            #     bash -c "source ~/bin/joshuto.sh; joshuto $argv"
            # end

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
            clean_cache = "~/bin/clean_cache";
        };
    };
}