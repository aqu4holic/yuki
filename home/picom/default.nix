{ config, pkgs, lib, ... }:
{
    services.picom = {
        enable = true;

        # backend = "xr_glx_hybrid";

        # fade = true;
        # fadeDelta = 4;
        # fadeSteps = [
        #     0.03
        #     0.03
        # ];

        # shadow = true;
        # # shadowOffsets = [
        # #     "-25"
        # #     "-25"
        # # ];
        # shadowOpacity = 0.5;

        # wintypes = {
        #     popup_menu = {
        #         opacity = 1.0;
        #     };

        #     dropdown_menu = {
        #         opacity = 1.0;
        #     };
        # };

#        settings = {
#            animations = {
#                animations = true;
#                animation-stiffness = 200;
#                animation-window-mass = 0.4;
#                animation-dampening = 20;
#                animation-clamping = false;
#                animation-for-open-window = "zoom"; #open window
#                animation-for-unmap-window = "zoom"; #minimize window
#                animation-for-workspace-switch-in = "slide-down"; #the windows in the workspace that is coming in
#                animation-for-workspace-switch-out = "zoom"; #the windows in the workspace that are coming out
#                animation-for-transient-window = "slide-up"; #popup windows
#            };
#        };

        # settings = builtins.readFile ./picom.conf;

        package = pkgs.writeScript "picom-wrapper" ''
            exec ${lib.getExe pkgs.picom} --config ${./picom.conf} $@;
        '';
    };

    # home.file.".config/picom/picom.conf" = {
    #     source = ./picom.conf;
    # };

    xresources.properties = {
        "Xcursor.size" = 16;
        "Xft.dpi" = 192;
    };
}
