{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraConfig = ''
            Host github.com
                ForwardAgent yes
                IdentityFile ~/.ssh/blackwhite_git
        '';
    };
}