{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "relative-motions-yazi";
    version = "latest";  # Use a specific version if available

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "dedukun";
        repo = "relative-motions.yazi";
        rev = "1d6d686d030c2c4841b58a2f1d6e7f3c965dbd0e";       # You can specify a specific commit hash instead
        sha256 = "sha256-pN8ToSMmvGr8b2EFpwV6V8PGC2773iRv0HdglqtUS3U=";  # Replace with the actual sha256 hash
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
