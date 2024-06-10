{config, ...}:
{
    imports = [
        ./kitty

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