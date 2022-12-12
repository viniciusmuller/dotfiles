{ pkgs, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./config;
    emacsPackage = pkgs.emacs;
  };

  services.emacs.enable = true;
}
