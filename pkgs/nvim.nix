{ pkgs, config, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
}