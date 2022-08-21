{ pkgs, prelude, ... }:

let
  pears = {
    plugin = pkgs.vimPlugins.pears-nvim;
    config = prelude.mkLuaCode "require('pears').setup()";
  };
in
{
  programs.neovim.plugins = [ pears ];
}
