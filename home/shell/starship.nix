{ pkgs, config, ... }:

# fish

let
    font = "JetBrainsMono Nerd Font";
in
{
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = {
        enable = true;
        
        settings = {
            character = {
                success_symbol = "[➾](bold green)";
                error_symbol = "[➾](bold red)";
            };

            add_newline = true;

            format = " $nix_shell$username$hostname$directory$git_branch$git_commit$git_state$git_status$jobs$cmd_duration$character";

            right_format = "$time";

            shell = {
                disabled = false;
                format = "$indicator";
                fish_indicator = "🐟 ";
                bash_indicator = "[BASH](bright-white) ";
                zsh_indicator = "[ZSH](bright-white) ";
            };
            username = {
                disabled = false;
                show_always = true;
                format =  "[$user]($style)";
                style_user = "#00c8ff";
                style_root = "#ff006a";
            };
            hostname = {
                format = "@[$hostname]($style) ";
                disabled = false;
                style = "#ff006a";
                ssh_only = false;
            };
            git_branch = {
                only_attached = true;
                format = "[$symbol$branch]($style) ";
                symbol = "";
                style = "bright-yellow bold";
            };
            git_commit = {
                only_detached = true;
                format = "[ﰖ$hash]($style) ";
                style = "bright-yellow bold";
            };
            git_state = {
                style = "bright-purple bold";
            };
            git_status = {
                style = "bright-green bold";
            };
            directory = {
                disabled = false;
                format = "📁[$path]($style)[$read_only]($read_only_style) ";
                read_only = " 🔒";
                truncation_length = 0;
                truncate_to_repo = false;
            };
            cmd_duration = {
                disabled = false;
                format = "[$duration]($style) ";
                style = "bright-blue";
            };
            time = {
                disabled = false;
                use_12hr = true;
                format = "[$time]($style) 🕙";
                style = "#00ffc3";
            };
            jobs = {
                disabled = false;
                style = "bright-green bold";
            };
        };
    };
}