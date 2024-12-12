{ pkgs, config, ... }:
{
    services.redshift = {
        enable = true;

        temperature = {
            day = 6000;
            night = 3200;
        };

        latitude = 12.25;
        longitude = 109.0;
    };
}
