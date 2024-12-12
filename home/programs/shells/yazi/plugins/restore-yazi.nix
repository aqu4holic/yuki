{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
    pname = "restore-yazi";
    version = "latest";

    src = fetchFromGitHub {
        owner = "boydaihungst";
        repo = "restore.yazi";
        rev = "a024f0a93d61dcdb57ba58c0f4a66eca55f93454";
        sha256 = "sha256-oTAhrd6gNCR6j5Q4eVsVhKpWui2nrIVhBrjMo30ZQL4=";
    };

    installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/
    '';
}
