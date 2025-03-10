{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "relative-motions-yazi";
    version = "latest";  # Use a specific version if available

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "dedukun";
        repo = "relative-motions.yazi";
        rev = "810306563e1928855f5cf61f83801544e3eb3788";       # You can specify a specific commit hash instead
        sha256 = "sha256-sIS7vtpY8z8D1nHMmr/uZoKREeGsIZuNSG8SnKkjREI=";  # Replace with the actual sha256 hash
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
