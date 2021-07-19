{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    matklad.rust-analyzer
  ];
}
