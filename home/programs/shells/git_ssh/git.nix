{ pkgs, ... }:
{
    programs.git = {
        enable = true;
        lfs.enable = true;

        userName = "aqu4holic";
        userEmail = "gautruc.anh1234@gmail.com";

        delta = {
            enable = true;
        };
    };
}
