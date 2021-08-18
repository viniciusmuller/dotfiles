{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotifyd
    spotify-tui
  ];
}
