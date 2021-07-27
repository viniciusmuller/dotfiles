{ pkgs, ... }:

{
  imports = [
    # Sets up things such as .haskeline and .ghci files
    ../../ghc
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    haskell.haskell
    justusadam.language-haskell
  ];
}
