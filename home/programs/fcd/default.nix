{ inputs, config, pkgs, libs, ... }:
let
    freerdp-fci = pkgs.callPackage ./freerdp-fci.nix {};
in
{
    home.packages = [
        freerdp-fci
    ];
}
