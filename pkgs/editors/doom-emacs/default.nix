{ pkgs, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    # TODO: Use emacsGcc here
    # emacsPackage = pkgs.emacsGcc;
  };
}
