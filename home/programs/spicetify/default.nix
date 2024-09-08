{ config, pkgs, lib, inputs, ... }:
let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];

    imports = [ inputs.spicetify-nix.homeManagerModule ];

    home.packages = with pkgs; [
        spotify
    ];

    # programs.spicetify = {
    #     enable = false;
    #     # theme = spicePkgs.themes.catppuccin;
    #     # colorScheme = "mocha";
    #
    #     enabledExtensions = with spicePkgs.extensions; [
    #         fullAppDisplayMod
    #         shuffle # shuffle+ (special characters are sanitized out of ext names)
    #         hidePodcasts
    #         genre
    #         powerBar
    #         playlistIcons
    #         goToSong
    #         songStats
    #         showQueueDuration
    #         copyToClipboard
    #         history
    #         playNext
    #         volumePercentage
    #     ];
    # };
}
