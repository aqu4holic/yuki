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
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERMINAL = "kitty";
    };
}
