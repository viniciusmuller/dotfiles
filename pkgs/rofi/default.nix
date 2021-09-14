{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ./onedark.rasi;
    font = "JetBrains Mono 11";
  };
}

