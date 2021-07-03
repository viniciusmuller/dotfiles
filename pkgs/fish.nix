{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = "
    set fish_greeting
    ";
  };
}

