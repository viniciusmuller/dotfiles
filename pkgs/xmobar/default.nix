{ pkgs, ... }:

{
  home.packages = [ pkgs.xmobar ];
  home.file = {
    ".xmobarrc".source = ./xmobar.hs;
  };
}
