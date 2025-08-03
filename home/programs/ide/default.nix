{ config, pkgs, ...}:
let
    inherit (pkgs.stdenv.hostPlatform) system;
    throwSystem = throw "Unsupported system: ${system}";
    plat = {
        x86_64-linux = "linux-x64";
        x86_64-darwin = "darwin";
        aarch64-linux = "linux-arm64";
        aarch64-darwin = "darwin-arm64";
        armv7l-linux = "linux-armhf";
    }.${system} or throwSystem;

    archive_fmt = if pkgs.stdenv.hostPlatform.isDarwin then "zip" else "tar.gz";

    vscode_version = "1.102.2";
    vscode_rev = "c306e94f98122556ca081f527b466015e1bc37b0";
    vscode_server_hash = "sha256-tvbyqgH8nF0mui0UnDAvN2LdjcB8GQVbSg48cwe6BFA=";
    vscode_hash = {
        x86_64-linux = "sha256-BzJWy/dxOhHilMKh1+w4W569MFudBKAU4fycrYLLW/0=";
        x86_64-darwin = "sha256-dPtStLcmFm9Zf3gRYz/37qHvV3hEfV3nW/N7TVjI8B8=";
        aarch64-linux = "sha256-x4f7y2r0CBE8ubwnQNmCIjQOA07/6qW563FqFnn6V5Q=";
        aarch64-darwin = "sha256-c64gB5t0U0glgcfMlCvVBphQ3rsX758vCUFPVNWqTJY=";
        armv7l-linux = "sha256-I2uhURbxv1aGruOn28xCssGxPjvEs9qzTfRIZFiKVRI=";
    }.${system} or throwSystem;
in
{
    programs.vscode = {
        enable = true;
        # package = pkgs.vscode-fhs.overrideAttrs (old: rec {
        #     version = vscode_version;
        #     rev = vscode_rev;
        #     src = pkgs.fetchurl {
        #         name = "VSCode_${version}_${plat}.${archive_fmt}";
        #         url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
        #         hash = vscode_hash;
        #     };
        #
        #     vscodeServer = pkgs.srcOnly {
        #         name = "vscode-server-${rev}.tar.gz";
        #         src = pkgs.fetchurl {
        #             name = "vscode-server-${rev}.tar.gz";
        #             url = "https://update.code.visualstudio.com/commit:${rev}/server-linux-x64/stable";
        #             hash = "sha256-tvbyqgH8nF0mui0UnDAvN2LdjcB8GQVbSg48cwe6BFA=";
        #         };
        #         stdenv = pkgs.stdenvNoCC;
        #     };
        # });
        # package = ((pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
        #     src = (builtins.fetchTarball {
        #        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        #        sha256 = "0rzjbggyipvglvgxn75lyarxg873q38vslkj3sr937xxpnzkg77i";
        #     });
        #     version = "latest";
        #
        #     # buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
        # })).fhs;
        package = pkgs.vscode.fhs;
        mutableExtensionsDir = true;
        # extensions = with pkgs.vscode-extensions; [
        #     llvm-vs-code-extensions.vscode-clangd
        #     mkhl.direnv
        # ];
    };

    programs.zed-editor = {
        enable = true;
    };
}
