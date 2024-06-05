{ pkgs, ... }:
{
    programs.git = {
        enable = true;

        userName = "openai";
        userEmail = "chauhuynhnoc@gmail.com";
    };
}