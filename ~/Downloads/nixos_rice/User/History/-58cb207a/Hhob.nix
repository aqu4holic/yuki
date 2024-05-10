{config, ...}:
{
    imports = [
        ./common.nix
        ./terminals.nix
        ./fish
        ./starship.nix
    ];

    home.sessionVariables = {
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "kitty";
    };
}