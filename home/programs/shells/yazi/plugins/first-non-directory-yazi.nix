{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "first-non-directory-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "lpanebr";
        repo = "yazi-plugins";
        rev = "ca18a2cfb893e3608997c9de54acced124373871";
        sha256 = "sha256-U6rr3TrFTtnibrwJdJ4rN2Xco4Bt4QbwEVUTNXlWRps=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/first-non-directory.yazi/* $out/
    '';
}
