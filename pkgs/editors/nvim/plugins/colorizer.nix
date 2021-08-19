{ pkgs, ... }:

let
  colorizer = {
    plugin = pkgs.vimPlugins.nvim-colorizer-lua;
    config = ''
      set termguicolors
      lua require('colorizer').setup()
    '';
  };
in
{
  programs.neovim.plugins = [ colorizer ];
}
