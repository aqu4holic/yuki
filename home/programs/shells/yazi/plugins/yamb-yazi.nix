{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "yamb-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "22af0033be18eead7b04c2768767d38ccfbaa05b";
        sha256 = "sha256-NMxZ8/7HQgs+BsZeH4nEglWsRH2ibAzq7hRSyrtFDTA=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
