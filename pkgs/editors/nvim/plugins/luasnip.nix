{ pkgs, prelude, ... }:

let
  luasnip = {
    plugin = pkgs.vimPlugins.luasnip;
    config = prelude.mkLuaCode ''
      require('luasnip.loaders.from_vscode').load()
    '';
  };
in
{
  programs.neovim.plugins = [
    luasnip
    pkgs.vimPlugins.friendly-snippets
  ];
}
