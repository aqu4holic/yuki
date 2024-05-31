{ config, pkgs, ... }:
{
    services.polybar = {
        enable = true;

        config = {

        };

        script = builtins.readFile ./launch.sh;

        # config =
    };
}