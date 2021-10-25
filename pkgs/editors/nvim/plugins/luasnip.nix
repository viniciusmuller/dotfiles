{ pkgs, ... }:

let
  luasnip = {
    plugin = pkgs.vimPlugins.luasnip;
    config = "lua require('luasnip').setup()";
  };
in
{
  programs.neovim.plugins = [ luasnip ];
}
