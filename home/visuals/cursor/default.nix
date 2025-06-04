{ config, pkgs, ... }:
{
    home.pointerCursor = {
        size = 30;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        # name = "Bibata-Modern-Ice";

        x11 = {
            enable = true;
            defaultCursor = "left_ptr";
        };
    };
}
