{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "mediainfo-yazi";
    version = "latest";  # Replace with a specific version if available

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "Ape";
        repo = "mediainfo.yazi";
        rev = "447fe95239a488459cfdbd12f3293d91ac6ae0d7";       # Replace with a specific commit hash if preferred
        sha256 = "sha256-U6rr3TrFTtnibrwJdJ4rN2Xco4Bt4QbwEVUTNXlWRps=";  # Replace with the actual sha256
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
