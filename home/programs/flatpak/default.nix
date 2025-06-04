{ inputs, config, pkgs, ... }:
{
    # imports = [
    #     inputs.flatpaks.homeManagerModules.nix-flatpak
    # ];

    services.flatpak.packages = [
        "com.github.flxzt.rnote"
        # "com.usebottles.bottles"
    ];
}
