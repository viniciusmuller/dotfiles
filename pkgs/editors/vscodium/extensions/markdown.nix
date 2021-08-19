{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    yzhang.markdown-all-in-one
  ];
}
