{ lib, stdenv, fetchFromGitHub }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "nbpreview-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "AnirudhG07";
        repo = "nbpreview.yazi";
        rev = "7fb073fd29a98807bc6032327b475ec9b0b5479f";  # Replace with a specific commit hash if preferred
        sha256 = "sha256-bg/sXnY8m+bCNp1kwz7+t15LxZoICe2fYWGX1Q4QSCo=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
