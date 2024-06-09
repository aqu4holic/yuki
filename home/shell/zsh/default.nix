{ config, pkgs, ... }:
{
    programs.zsh = {
        enable = false;

        enableCompletion = true;
        autosuggestion = {
            enable = true;
            highlight = "fg=#6e5870,underline";
        };

        syntaxHighlighting.enable = true;
        autocd = true;
        defaultKeymap = "emacs";

        initExtra = ''
            export GTK_IM_MODULE=ibus
            export QT_IM_MODULE=ibus
            export XMODIFIERS=@im=ibus

            export QT4_IM_MODULE=ibus

            export CLUTTER_IM_MODULE=ibus
            export GLFW_IM_MODULE=ibus

            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word

            zstyle ':completion:*' matcher-list ''' \
            'm:{a-z\-}={A-Z\_}' \
            'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
            'r:|?=** m:{a-z\-}={A-Z\_}'
            # eval "$(direnv hook zsh)"

            source ~/.profile
            # for conda
            source ~/.conda/etc/profile.d/conda.sh

            # for bluetooth, it will crash without this
            dbus-update-activation-environment DISPLAY

            eval "$(ssh-agent -c)" &>/dev/null

            function joshuto() {
                ID="$$"
                mkdir -p /tmp/$USER
                OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
                # env ~/bin/joshuto_ueberzugpp --output-file "$OUTPUT_FILE" $@
                env joshuto --output-file "$OUTPUT_FILE" $@
                exit_code=$?

                case "$exit_code" in
                    # regular exit
                    0)
                        ;;
                    # output contains current directory
                    101)
                        JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
                        cd "$JOSHUTO_CWD"
                        ;;
                    # output selected files
                    102)
                        ;;
                    *)
                        echo "Exit code: $exit_code"
                        ;;
                esac
            }
        '';

        shellAliases = {
            update = "sudo nixos-rebuild switch";
            j = "joshuto";
            v = "nvim";
            c = "code";
            g = "git";
            gaa = "git add .";
            gcm = "git commit -m";
            gp = "git push";
            ca = "conda activate";
            cs = "conda-shell -c zsh";
            clean_cache = "~/bin/clean_cache";
        };

        history = {
            ignoreAllDups = true;
            size = 100000;
        };
    };
}