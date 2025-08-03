{ config, xdg, pkgs, ... }:
{
    systemd.user.services.xdg-desktop-portal-gtk = {
        wantedBy = [ "xdg-desktop-portal.service" ];
        before = [ "xdg-desktop-portal.service" ];
    };

    services = {
        resolved.enable = true;
        xserver.desktopManager.runXdgAutostartIfNone = true;

        gnome.gnome-keyring.enable = true;
    };

    security.pam.services = {
        agetty.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
    };

    systemd = {
        targets = {
            sleep = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            suspend = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            hibernate = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
            "hybrid-sleep" = {
                enable = false;
                unitConfig.DefaultDependencies = "no";
            };
        };
    };

    # virtualisation
    virtualisation = {
        docker = {
            enable = true;
            # daemon.settings = {
            #     experimental = true;
            #     default-address-pools = [
            #         {
            #             base = "172.30.0.0/16";
            #             size = 24;
            #         }
            #     ];
            #     dns = [ "1.1.1.1" "8.8.8.8" ];
            #     iptables = false;
            #     registry-mirrors = [ "https://mirror.gcr.io" ];
            # };

            # use docker without root access (rootless docker)
            rootless = {
                enable = true;
                # daemon.settings = {
                #     dns = [ "1.1.1.1" "8.8.8.8" ];
                #     registry-mirrors = [ "https://mirror.gcr.io" ];
                # };
                setSocketVariable = true;
            };
        };

        # # virt-manager
        # spiceUSBRedirection.enable = true;
        # libvirtd = {
        #     enable = true;
        #     qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        # };
    };
    # services.qemuGuest.enable = true;
    # services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
    # programs.virt-manager.enable = true;
}
