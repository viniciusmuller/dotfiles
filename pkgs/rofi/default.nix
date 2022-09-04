{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    # theme = "dmenu";
    font = "JetBrains Mono 11";
  };
}

