{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "compress-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "KKV9";
        repo = "compress.yazi";
        rev = "60b24af23d1050f1700953a367dd4a2990ee51aa";
        sha256 = "sha256-Yf5R3H8t6cJBMan8FSpK3BDSG5UnGlypKSMOi0ZFqzE=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
