{ inputs, config, pkgs, libs, ... }:
{
    home.packages = with pkgs; [
        python312
        # python312Packages.pip
        # python312Packages.venvShellHook
    ];
}
