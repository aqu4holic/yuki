{config, ...}:
{
    imports = [
        ./common.nix
        ./terminals.nix
        ./fish.nix
    ];

    home.sessionVariables = {
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "kitty";
    };
}