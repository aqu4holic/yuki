{ pkgs, config, ... }:
{
    programs = {
        direnv = {
            enable = true;
            nix-direnv.enable = true;

            # enableFishIntegration = true;
            # enableZshIntegration = true;
        };
    };

    home.packages = with pkgs; [
        devenv
    ];
}
