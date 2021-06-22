{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
  ];
}
