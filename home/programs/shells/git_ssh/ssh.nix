{ pkgs, lib, ... }:
{
    programs.ssh = {
        enable = true;
        # addKeysToAgent = "yes";

        # extraConfig = builtins.readFile ./config;
    };

    # home.activation.fixSshConfigPerms = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #     chmod 600 ~/.ssh/config
    # '';

    home.file = {
        ".ssh/config" = {
            source = ./config;
            target = ".ssh/config_source";

            onChange = ''
                cat ~/.ssh/config_source > ~/.ssh/config && chmod 600 ~/.ssh/config
            '';
        };
    };
}
