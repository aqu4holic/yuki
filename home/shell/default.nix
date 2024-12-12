{config, ...}:
{
    imports = [
        ./kitty

        ./direnv

        ./fish
        ./zsh

        ./starship

        # ./scripts
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "zen";
        TERMINAL = "kitty";
    };
}
