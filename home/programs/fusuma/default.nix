{ config, pkgs, libs, callPackage, ... }:
let
    importYAML = file: builtins.fromJSON (
        builtins.readFile (
            pkgs.runCommandNoCC "converted-yaml.json" {
                nativeBuildInputs = [ pkgs.yq ];
            } ''
                cat "${file}" | yq > "$out"
            ''
        )
    );
in
{
    services.fusuma = {
        enable = true;

        settings = importYAML ./config.yml;
    };

    # xdg.configFile."fusuma/config.yml" = {
    #     source = ./config.yml;
    # };
}
