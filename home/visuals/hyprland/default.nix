{ inputs, config, pkgs, libs, lib, ... }:
{
    imports = [
        # ./wofi
        # ./quickshell
    ];

    # remember to put the plugins settings
    # wayland.windowManager = {
    #     hyprland = {
    #         enable = false;
    #         xwayland.enable = true;
    #         plugins = with hyprlandPlugins; [
    #             # hyprspace
    #             hyprexpo
    #         ];
    #     };
    # };

    # todo
    # waybard, hyprlock, hyprland
    # eww/dunst or quickshell...
    # ibus/fcitx5

    programs = {
        # quickshell = {
        #     enable = true;
        #     systemd.enable = true;
        # };
    };

    services = {
        # cliphist = {
        #     enable = true;
        # };
        swww = {
            enable = true;
        };
        # swaync = {
        #     enable = true;
        # };
    };

    home.sessionVariables = {
        HYPRLAND_PLUGIN_DIR = pkgs.symlinkJoin {
            name = "hyrpland-plugins";
            paths = with pkgs.hyprlandPlugins; [
                hyprexpo
                hyprspace
            ];
        };

        # NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        CLUTTER_BACKEND = "wayland";
        XDG_SESSION_DESKTOP = "wayland";
        OZONE_PLATFORM = "wayland";
        QT_QPA_PLATFORM = "wayland";
    };

    # home.file.".config/electron-flags.conf".text = ''
    #     --enable-features=UseOzonePlatform
    #     --ozone-platform=wayland
    #     --use-gl=egl-angle
    #     --use-angle=opengl
    # '';

    home.packages = with pkgs; [
        grim
        slurp
        swaynotificationcenter
    ];
}
