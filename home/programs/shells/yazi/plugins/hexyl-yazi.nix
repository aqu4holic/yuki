{ lib, stdenv, fetchFromGitHub }:

# Define a simple package without build steps
stdenv.mkDerivation rec {
    pname = "hexyl-yazi";
    version = "latest";

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "Reledia";
        repo = "hexyl.yazi";
        rev = "ccc0a4a959bea14dbe8f2b243793aacd697e34e2";  # Replace with a specific commit hash if needed
        sha256 = "sha256-9rPJcgMYtSY5lYnFQp3bAhaOBdNUkBaN1uMrjen6Z8g=";
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
