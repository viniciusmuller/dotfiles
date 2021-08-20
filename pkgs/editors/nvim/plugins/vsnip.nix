{ pkgs, ... }:

let
  vsnip = {
    plugin = pkgs.vimPlugins.vim-vsnip;
  };
in
{
  programs.neovim.plugins = [ vsnip ];
}
