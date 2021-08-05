{ pkgs, prelude, ... }:

let
  autopairs = {
    plugin = pkgs.vimPlugins.nvim-autopairs;
    config = prelude.mkLuaCode ''
      require('nvim-autopairs').setup()
      require("nvim-autopairs.completion.compe").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true -- it will auto insert `(` after select function or method item
      })
    '';
  };
in
{
  programs.neovim.plugins = [ autopairs ];
}
