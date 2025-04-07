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

            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list ''' \
            'm:{a-z\-}={A-Z\_}' \
            'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
            'r:|?=** m:{a-z\-}={A-Z\_}'
            eval "$(direnv hook zsh)"

            # for bluetooth, it will crash without this
            dbus-update-activation-environment DISPLAY

            eval "$(ssh-agent -c)" &>/dev/null

            function y() {
            	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            	yazi "$@" --cwd-file="$tmp"
            	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            		builtin cd -- "$cwd"
            	fi
            	rm -f -- "$tmp"
            }
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

            joern = "$HOME/.local/bin/joern/joern-cli/joern";
            joern-cpg2scpg = "$HOME/.local/bin/joern/joern-cli/joern-cpg2scpg";
            joern-export = "$HOME/.local/bin/joern/joern-cli/joern-export";
            joern-flow = "$HOME/.local/bin/joern/joern-cli/joern-flow";
            joern-parse = "$HOME/.local/bin/joern/joern-cli/joern-parse";
            joern-scan = "$HOME/.local/bin/joern/joern-cli/joern-scan";
            joern-slice = "$HOME/.local/bin/joern/joern-cli/joern-slice";
            joern-vectors = "$HOME/.local/bin/joern/joern-cli/joern-vectors";

            vc = "python3 -m venv venv";
            va = "source venv/bin/activate";
            vca = "python3 -m venv venv && source venv/bin/activate";

            s = "kitten ssh";
            cs = "conda-shell -c fish";
        };

        history = {
            ignoreAllDups = true;
            size = 100000;
        };
    };
}
