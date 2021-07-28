{ pkgs, ... }:

let
  fugitive = {
    plugin = pkgs.vimPlugins.vim-fugitive;
    config = ''
      nnoremap <silent> <Leader>gg :tab G<cr>
      nnoremap <silent> <Leader>gd :Gvdiffsplit<cr>
      nnoremap <silent> <Leader>gD :!git diff<cr>
      nnoremap <silent> <Leader>gl :Gclog<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ fugitive ];
}
