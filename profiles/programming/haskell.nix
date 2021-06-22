{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    haskell.haskell
    justusadam.language-haskell
  ];
}
