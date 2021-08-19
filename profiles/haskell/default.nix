{ pkgs, ... }:

{
  home.file = {
    ".ghci".source = ./.ghci;
    ".haskeline".source = ./.haskeline;
  };
}
