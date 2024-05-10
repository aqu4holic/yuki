{pkgs, ...}:
{
    home.packages = with pkgs; [
        fish
        kitty
    ];
}