{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "first-non-directory-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "lpanebr";
        repo = "yazi-plugins";
        rev = "4e0fc1be928b7b8cfb38576710e572fbb92aba99";
        sha256 = "sha256-DiU2SLmjavBnNDivAO9e5oqvaRr/zYz0ER4Uj04hHOE=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/first-non-directory.yazi/* $out/
    '';
}
