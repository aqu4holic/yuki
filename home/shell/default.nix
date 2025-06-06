{config, ...}:
{
    imports = [
        ./kitty

        ./env

        ./fish
        ./zsh

        ./starship

        # ./scripts
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "zen";
        TERMINAL = "kitty";
        TERM = "kitty";
    };
}
