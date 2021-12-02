{ pkgs, lib, ... }:

let
  leader-mappings = {
    plugin = pkgs.writeText "dummy" "";
    config = ''
      let mapleader = " "
      let maplocalleader = ","
    '';
  };
in
{
  programs.neovim.plugins = lib.mkBefore [ leader-mappings ];
}
