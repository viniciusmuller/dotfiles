{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aseprite-unfree
    godot
  ];
}
