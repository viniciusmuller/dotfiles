{ pkgs, config, ... }:

let
  emacs-pkg = pkgs.emacsUnstable;
in
{
  home.packages = with pkgs; [
    # org-roam
    # graphviz
  ];

  programs.doom-emacs = {
    enable = true;
    emacsPackage = emacs-pkg;
    doomPrivateDir = ./config;
  };
}
