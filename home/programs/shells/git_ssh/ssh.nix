{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;
    };

    home.file = {
        # ".ssh/config_source" = {
        #     source = ./config;
        #
        #     # onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 600 ~/.ssh/config'';
        # };

        ".ssh/config" = {
            source = ./config;
            target = ".ssh/config_source";

            onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 600 ~/.ssh/config'';
        };
    };
}
