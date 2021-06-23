{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
  ];

  home.file = {
    ".ghci".source = ./.ghci;
    ".haskeline".source = ./.haskeline;
  };
}
