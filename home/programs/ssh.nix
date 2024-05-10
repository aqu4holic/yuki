{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraConfig = ''
            host github.com
                ForwardAgent yes
        '';
    };
}