{runCommand, yq}:
path:
let
    jsonOutputDrv =
        runCommand
        "from-yaml"
            { nativeBuildInputs = [ yq ]; }
        "yq -o=json . \"${path}\" > \"$out\"";
in
builtins.fromJSON (builtins.readFile jsonOutputDrv)
