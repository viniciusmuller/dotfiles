{ pkgs, prelude, ... }:

let
  gitsigns = {
    plugin = pkgs.vimPlugins.gitsigns-nvim;
    config = ''
        nnoremap <leader>gm <cmd>lua require('gitsigns').blame_line(true)<cr>

        ${prelude.mkLuaCode ''
        require('gitsigns').setup{}
      ''}
    '';
  };
in
{
  programs.neovim.plugins = [ gitsigns ];
}
