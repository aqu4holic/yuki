{ lib, stdenv, fetchFromGitHub, }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "glow-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "Reledia";
        repo = "glow.yazi";
        rev = "388e847dca6497cf5903f26ca3b87485b2de4680";
        sha256 = "sha256-fKJ5ld5xc6HsM/h5j73GABB5i3nmcwWCs+QSdDPA9cU=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
