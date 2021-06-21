{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = "
    set fish_greeting
    ";

    shellAliases = {
      "rb" = "sudo nixos-rebuild switch";
    };
  };
}

