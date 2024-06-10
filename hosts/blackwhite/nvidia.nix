{ config, pkgs, lib, ... }:
{
    # NVIDIA settings

    # Enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
        enableRedistributableFirmware = true;
    };

    hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        powerManagement = {
            # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
            # Enable this if you have graphical corruption issues or application crashes after waking
            # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
            # of just the bare essentials.
            enable = false;

            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern Nvidia GPUs (Turing or newer).
            finegrained = false;
        };

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        # package = config.boot.kernelPackages.nvidiaPackages.beta;
        package = config.boot.kernelPackages.nvidiaPackages.production;

        nvidiaPersistenced = false;

        prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";

            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
    };

    services.thermald.enable = lib.mkDefault true;

    services.tlp.settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
    };
}
