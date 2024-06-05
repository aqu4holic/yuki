{ inputs, config, pkgs, ...}:
{
    imports = [
        # inputs.catppuccin.homeManagerModules.catppuccin
        <home-manager/nixos>
    ];

    gtk = {
        enable = true;
        theme.name = "catppuccin";
        catppuccin = {
            enable = true;
            flavor = "mocha";
            accent = "pink";
            size = "standard";
            tweaks = [ "normal" ];
        };
    };
}