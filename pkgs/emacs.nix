{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.gccEmacs;
  };
}
