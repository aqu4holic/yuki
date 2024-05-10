{ pkgs, ... }:
{
    home.packages = [pkgs.gh];

    programs.git = {
        enable = true;

        userName = "aqu4holic";
        userEmail = "gautruc.anh1234@gmail.com";
    };
}