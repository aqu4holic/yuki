{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "what-size-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "pirafrank";
        repo = "what-size.yazi";
        rev = "f08f7f2d5c94958ac4cb66c51a7c24b4319c6c93";
        sha256 = "sha256-q0CKA8OTMgr8hCZ3CM/Jd/Gv4y68uJdMFeHhhJyHcbI=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
