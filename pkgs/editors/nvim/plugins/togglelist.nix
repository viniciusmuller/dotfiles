{ pkgs, ... }:

let
  togglelist = {
    plugin = pkgs.vimPlugins.vim-togglelist;
    config = ''
      let g:toggle_list_no_mappings = 1
      nnoremap <script> <silent> tl :call ToggleLocationList()<cr>
      nnoremap <script> <silent> tq :call ToggleQuickfixList()<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ togglelist ];
}
