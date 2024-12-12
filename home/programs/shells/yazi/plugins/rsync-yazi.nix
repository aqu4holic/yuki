{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "rsync-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "GianniBYoung";
        repo = "rsync.yazi";
        rev = "3f431aa388a645cc95b8292659949a77c280ed8b";
        sha256 = "sha256-xQHuMGg0wQQ16VbYKKnPLdLqKB6YgUlTpOOuxNNfhj8=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
