{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    deno
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [

  ];
}
