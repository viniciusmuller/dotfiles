{ pkgs, ... }:

let
  vsnip = {
    plugin = pkgs.vimPlugins.vim-vsnip;
    config = ''
    '';
  };
in
{
  programs.neovim.plugins = [ vsnip ];
}
