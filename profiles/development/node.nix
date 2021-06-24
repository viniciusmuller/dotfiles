{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    deno
    yarn
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [

  ];
}
