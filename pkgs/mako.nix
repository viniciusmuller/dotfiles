{ pkgs, colorscheme, ... }:

let
  colors = colorscheme.colors;
in
{
  programs.mako = {
    enable = true;
    font = "Jetbrains Mono 10";
    padding = "10,10";
    anchor = "top-center";
    width = 600;
    height = 125;
    borderSize = 2;
    defaultTimeout = 10000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
  };
}
