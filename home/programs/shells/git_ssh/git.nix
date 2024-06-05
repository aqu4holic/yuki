{ pkgs, ... }:
{
    programs.git = {
        enable = true;

        userName = "openai";
        userEmail = "gautruc.anh1234@gmail.com";
    };
}