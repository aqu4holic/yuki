{config, ...}:
{
    imports = [
        ./terminals.nix

        ./direnv

        ./fish
        ./zsh

        ./starship
    ];

    home.sessionVariables = {
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "kitty";
    };
}