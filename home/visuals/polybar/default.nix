{ config, pkgs, ... }:
{
    services.polybar = {
        enable = true;

        config = {

        };

        script = "polybar main &";

        settings = {
            "bar/main" = {

            };

            "module/volume" = {
                type = "internal/pulseaudio";
                format.volume = "<ramp-volume> <label-volume>";
                label.muted.text = "🔇";
                label.muted.foreground = "#666";
                ramp.volume = ["🔈" "🔉" "🔊"];
                click.right = "pavucontrol &";
            };
        };
    };
}