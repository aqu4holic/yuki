# NixOS configs

## Prerequisite
1. Clone this repo
```
    git clone git@github.com:Aqu4holic/nixos_rice.git
```

2. Create a symlink from the downloaded folder to `/etc/nixos`
```
    sudo ln -s nixos_rice/* /etc/nixos/
```

3. Rebuild the system
```
    sudo nixos-rebuild switch
```

## Things to do
this is on a VM, gotta update `hardware-configuration.nix` using `nixos-generate-config`.

thx for ur reading :)