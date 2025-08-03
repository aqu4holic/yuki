{ config, pkgs, lib, inputs, ... }:
let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
    programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";

        enabledExtensions = with spicePkgs.extensions; [
            fullAppDisplay
            shuffle # shuffle+ (special characters are sanitized out of ext names)
            # hidePodcasts
            betterGenres
            powerBar
            playlistIcons
            goToSong
            songStats
            showQueueDuration
            copyToClipboard
            history
            playNext
            volumePercentage
        ];
    };
}
