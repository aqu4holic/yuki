{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "open-with-cmd-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "Ape";
        repo = "open-with-cmd.yazi";
        rev = "8d7abc8a347bfa065b6d339d26480f6fdcfac37e";
        sha256 = "sha256-tUxdxOk2Dm2S/KRpc87aIEWU3SzQNm2/RaVT2Z1dqgQ=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
