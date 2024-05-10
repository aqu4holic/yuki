{config, ...}:
{
    imports = [
        ./common.nix
        ./terminals.nix
    ];

    home.sessionVariables = {
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "kitty";


    };
}