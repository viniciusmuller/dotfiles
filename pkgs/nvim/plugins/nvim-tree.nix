
{ pkgs, ... }:

let
  nvim-tree = {
    plugin = pkgs.vimPlugins.nvim-tree-lua;
    config = ''
      let g:nvim_tree_follow = 1
      nnoremap tn <cmd>NvimTreeToggle<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ nvim-tree ];
}
