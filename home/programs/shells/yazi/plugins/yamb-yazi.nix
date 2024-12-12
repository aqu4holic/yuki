{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "yamb-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "0598b8defc21ac7231e584115c3aa330f0310db4";
        sha256 = "sha256-Mw+CUyy8sN76NJNy+Xt0HwH6tD/gxqNvyIYKqpWUKMs=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
