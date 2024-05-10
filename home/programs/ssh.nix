{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraConfig = ''
            Host github.com
                ForwardAgent yes
                User aqu4holic
                IdentityFile ~/.ssh/blackwhite_git
        '';
    };
}