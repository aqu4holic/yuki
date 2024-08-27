{ config, pkgs, ... }:
{
    programs.zsh = {
        enable = false;

        enableCompletion = true;
        autosuggestion = {
            enable = true;
            highlight = "fg=#6e5870,underline";
        };

        syntaxHighlighting = {
            enable = true;

            highlighters = [
                "brackets"
                "main"
            ];

            styles = {
                default = "fg=#00d7d7";
                unknown-token = "fg=#e87c7c";
                path = "fg=#cba6f7,underline";
                alias = "fg=#89b4fa,bold";
                assign = "fg=#f5c2e7,bold";
                # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline";
            };
        };

        autocd = true;
        defaultKeymap = "emacs";

        # antidote = {
        #     enable = true;
        #     plugins = [
        #         "zsh-users/zsh-autosuggestions"
        #     ];
        # };

        initExtra = ''
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word

            source ~/.profile
            # for conda
            source ~/.conda/etc/profile.d/conda.sh

            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list ''' \
            'm:{a-z\-}={A-Z\_}' \
            'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
            'r:|?=** m:{a-z\-}={A-Z\_}'
            eval "$(direnv hook zsh)"

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
            e = "erd";
            gaa = "git add .";
            gcm = "git commit -m";
            gp = "git push";
            ca = "conda activate";
            cs = "conda-shell -c zsh";
        };

        history = {
            ignoreAllDups = true;
            size = 100000;
        };
    };
}