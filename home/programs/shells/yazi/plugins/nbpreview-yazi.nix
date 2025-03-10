{ lib, stdenv, fetchFromGitHub }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "nbpreview-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "AnirudhG07";
        repo = "nbpreview.yazi";
        rev = "f8879b382f441e881fc10bd18a523fd910737067";  # Replace with a specific commit hash if preferred
        sha256 = "sha256-iHfvLSUveHSRvYw5xFGuhSsTRC3xlY+PaooHnmA7Zzs=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
