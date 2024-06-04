{ inputs, config, pkgs, ...}:
{
    imports = [
        # inputs.catppuccin.homeManagerModules.catppuccin
        <home-manager/nixos>
    ];

    gtk = {
        enable = true;
        catppuccin = {
            enable = true;
            flavor = "mocha";
            accent = "pink";
            size = "standard";
            tweaks = [ "normal" ];
        };
    };
}