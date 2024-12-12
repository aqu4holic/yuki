{ lib, stdenv, fetchFromGitHub }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "eza-preview-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "sharklasers996";
        repo = "eza-preview.yazi";
        rev = "7ca4c2558e17bef98cacf568f10ec065a1e5fb9b";  # Replace with a specific commit hash if preferred
        sha256 = "sha256-ncOOCj53wXPZvaPSoJ5LjaWSzw1omHadKDrXdIb7G5U=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
