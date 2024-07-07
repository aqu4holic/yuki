{ pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraConfig = ''
            Host github.com
                HostName ssh.github.com
                User git
                PreferredAuthentications publickey
                ForwardAgent yes
                IdentityFile ~/.ssh/blackwhite_git
                AddKeysToAgent yes

            Host 112.137.129.158
                ForwardAgent yes
                AddKeysToAgent yes
                User phatnt
                Compression no
                ServerAliveInterval 0
                ServerAliveCountMax 3
                HashKnownHosts no
                UserKnownHostsFile ~/.ssh/known_hosts
                ControlMaster no
                ControlPath ~/.ssh/master-%r@%n:%p
                ControlPersist no

            Host 112.137.129.161
                ForwardAgent yes
                AddKeysToAgent yes
                User phatnt
                Compression no
                ServerAliveInterval 0
                ServerAliveCountMax 3
                HashKnownHosts no
                UserKnownHostsFile ~/.ssh/known_hosts
                ControlMaster no
                ControlPath ~/.ssh/master-%r@%n:%p
                ControlPersist no
        '';
    };
}
