{ config, pkgs, ... }:

{
  imports = [
    ../../pkgs/ghc
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions;
    [
      haskell.haskell
      justusadam.language-haskell
    ];
}
