{ inputs, ... }:
{
    catppuccin = {
        enable = false;
        flavor = "mocha";
        accent = "maroon";

        grub = {
            enable = true;
            flavor = "mocha";
        };
    };
}
