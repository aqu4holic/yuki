{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraConfig = ''
        Host github.com
            User git
            Hostname ssh.github.com
            PreferredAuthentications publickey
            ForwardAgent yes
            IdentityFile ~/.ssh/blackwhite_git
            AddKeysToAgent yes
        '';
    };
}
