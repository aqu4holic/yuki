{config, ...}:
{
    imports = [
        ./terminals.nix

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