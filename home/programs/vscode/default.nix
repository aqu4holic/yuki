{ config, pkgs, ...}:
{
    programs.vscode = {
        enable = true;
        # package = pkgs.vscode.fhs;
        package = pkgs.vscode;

        extensions = with pkgs.vscode-extensions; [
            llvm-vs-code-extensions.vscode-clangd
            mkhl.direnv
        ];
    };
}