{ pkgs, prelude, ... }:

let
  luasnip = {
    plugin = pkgs.vimPlugins.luasnip;
  };
in
{
  programs.neovim.plugins = [
    luasnip
  ];
}
