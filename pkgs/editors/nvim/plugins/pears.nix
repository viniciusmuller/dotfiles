{ pkgs, ... }:

let
  pears = {
    plugin = pkgs.vimPlugins.pears-nvim;
    config = "lua require('pears').setup()";
  };
in
{
  programs.neovim.plugins = [ pears ];
}
