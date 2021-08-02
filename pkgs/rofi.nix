{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
    font = "JetBrains Mono 11";
  };
}

