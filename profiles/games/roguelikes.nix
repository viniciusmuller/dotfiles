{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nethack
    brogue
  ];
}
