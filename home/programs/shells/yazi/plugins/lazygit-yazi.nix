{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "lazygit-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "Lil-Dank";
        repo = "lazygit.yazi";
        rev = "c82794fb410cca36b23b939d32126a6a9705f94d";
        sha256 = "sha256-m2zITkjGrUjaPnzHnnlwA6d4ODIpvlBfIO0RZCBfL0E=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
