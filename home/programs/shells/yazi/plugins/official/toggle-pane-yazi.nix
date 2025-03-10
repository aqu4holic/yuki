{ lib, stdenv, fetchFromGitHub }:
let inherit (import ./rev_sha.nix) main_rev main_sha256; in
stdenv.mkDerivation rec {
    pname = "toggle-pane-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = main_rev;
        sha256 = main_sha256;
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/toggle-pane.yazi/* $out/
        [ -f LICENSE ] && cp LICENSE $out/ || touch $out/LICENSE
    '';
}
