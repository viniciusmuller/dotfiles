{ pkgs, ... }:

{
  home.packages = with pkgs; [
    blugon
  ];

  home.file = {
    ".config/blugon/config".source = ./config;
    ".config/blugon/gamma".source = ./gamma;
  };

  # TODO: Enable blugon.service in userland
}
