{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
  ];
}
