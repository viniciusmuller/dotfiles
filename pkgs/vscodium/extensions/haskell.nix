{ pkgs, ... }:

{
  imports = [
    ../../ghc
  ];

  home.packages = with pkgs; [ stack ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    haskell.haskell
    justusadam.language-haskell
  ];
}
