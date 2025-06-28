{config, ...}:
{
    imports = [
        ./kitty

        ./env

        ./fish

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
