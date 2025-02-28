{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "chmod-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "139c36e4a77660b85fd919b1c813257c938f3db3";
        sha256 = "sha256-84lrFEdJ2oqEaZj5VfLU1HLrvX6LziWo+HtKNT2JErw=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/chmod.yazi/* $out/
    '';
}
