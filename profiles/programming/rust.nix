{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rustfmt
    clippy
    rustc
    cargo
    gcc
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    matklad.rust-analyzer
  ];
}
