{ pkgs, stdEnv, ... }:

let
  # TODO: Find a way to use kmonad
  kmonad-git = builtins.fetchGit
    {
      url = "https://github.com/kmonad/kmonad";
      rev = "ca1c76de39ebde6a8ae1aa4f96477c6939b68f8a";
    };
  kmonad = stdEnv.mkDerivation { };
in
{ }
