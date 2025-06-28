# freerdp-fci.nix
{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook
, openssl
, zlib
, glibc
, gcc
}:
stdenv.mkDerivation rec {
    pname = "freerdp-fci";
    version = "3.0.8.2";

    src = fetchurl {
        url = "https://launchpad.net/~fptsmartcloud/+archive/ubuntu/ppa/+files/freerdp-fci/3.0.8.2/freerdp-fci_3.0.8.2_amd64.deb";
        sha256 = "sha256-/4DjAsMy+7m/0ExxtTuEkndYSn4iVMV8Rl+r7imjQlw=";  # <- fill in with real hash
    };

    nativeBuildInputs = [ autoPatchelfHook dpkg ];
    buildInputs = [ openssl zlib glibc gcc ];

    phases = [ "unpackPhase" "installPhase" ];

    unpackPhase = ''
        dpkg-deb -x $src .
    '';

    installPhase = ''
        mkdir -p $out
        cp -r opt/* $out/

        mkdir -p $out/bin
        ln -s $out/freerdp-nightly/bin/xfreerdp3 $out/bin/xfreerdp3
    '';

    meta = with lib; {
        description = "Custom FreeRDP client from FPT Smart Cloud (.deb wrapped)";
        homepage = "https://www.fptsmartcloud.vn/";
        license = licenses.unfreeRedistributable;  # Most likely
        platforms = platforms.linux;
        maintainers = [ ];
    };
}
