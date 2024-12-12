{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "catppuccin-mocha-yazi";
    version = "latest";  # Use the appropriate version or commit

    # Fetch the source from GitHub
    src = fetchFromGitHub {
        owner = "yazi-rs";  # GitHub owner
        repo = "flavors";   # GitHub repository name
        rev = "4a3082f4e96914f2fd9c5e42714c27173526fbb3";       # You can specify a specific commit here
        sha256 = "sha256-O6lYGY1DdMUTG9rrB+1R2i4KFgDEWsksp5MYbDmAvJo=";  # You will need to get the correct hash
    };

    # No build or install steps needed, just copy the source to $out
    installPhase = ''
        mkdir -p $out
        cp -r $src/catppuccin-mocha.yazi/* $out/
    '';
}
