{ lib, stdenv, fetchFromGitHub }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "nbpreview-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "AnirudhG07";
        repo = "nbpreview.yazi";
        rev = "52a14b39ce55f1c689f44f0d1cbeb44e925a2012";  # Replace with a specific commit hash if preferred
        sha256 = "sha256-l327I4uxb8RUHvSnQ4xaeZrmtVyhwAu9CU5tQLDOHw4=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
