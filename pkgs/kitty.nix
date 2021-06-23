{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.package = pkgs.jetbrains-mono;
    font.name = "Jetbrains Mono";
    font.size = 9;
  };
}
