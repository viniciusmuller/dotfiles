{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    tamasfe.even-better-toml
  ];
}
