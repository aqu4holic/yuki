{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "mediainfo-yazi";
    version = "latest";  # Replace with a specific version if available

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "Ape";
        repo = "mediainfo.yazi";
        rev = "c69314e80f5b45fe87a0e06a10d064ed54110439";       # Replace with a specific commit hash if preferred
        sha256 = "sha256-8xdBPdKSiwB7iRU8DJdTHY+BjfR9D3FtyVtDL9tNiy4=";  # Replace with the actual sha256
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
