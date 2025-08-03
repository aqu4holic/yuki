{ config, pkgs, lib, ... }:
let
    customNVIDIADriver = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.172.08";
        sha256_64bit = "sha256-AlaGfggsr5PXsl+nyOabMWBiqcbHLG4ij617I4xvoX0=";
        sha256_aarch64 = "sha256-FVRyFvK1FKznckpatMMydmmQSkHK+41NkEjTybYJY9g=";
        openSha256 = "sha256-aTV5J4zmEgRCOavo6wLwh5efOZUG+YtoeIT/tnrC1Hg=";
        settingsSha256 = "sha256-N/1Ra8Teq93U3T898ImAT2DceHjDHZL1DuriJeTYEa4=";
        persistencedSha256 = "sha256-x4K0Gp89LdL5YJhAI0AydMRxl6fyBylEnj+nokoBrK8=";
    };
in
{
    # NVIDIA settings

    # Enable OpenGL
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            nvidia-vaapi-driver
            intel-media-driver
        ];

        extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
    };
    # boot.kernelParams = [
    #     "i915.force_probe=46a6"
    # ];
    # environment.sessionVariables = { LIBVA_DRIVER_NAME = lib.mkForce "iHD"; };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

    hardware = {
        enableRedistributableFirmware = true;
    };

    boot.extraModulePackages = [ customNVIDIADriver ];

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
        open = true;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
        package = customNVIDIADriver;

        nvidiaPersistenced = true;

        prime = {
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";

            offload = {
                enable = true;
                enableOffloadCmd = true;
            };
        };
    };

    # specialisation = {
    #     gpu_always.configuration = {
    #         hardware.nvidia.prime = {
    #             sync.enable = lib.mkForce true;

    #             offload = {
    #                 enable = lib.mkForce false;
    #                 enableOffloadCmd = lib.mkForce false;
    #             };
    #         };
    #     };
    # };

    services.thermald.enable = lib.mkDefault true;

    services.tlp.settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
    };
}
