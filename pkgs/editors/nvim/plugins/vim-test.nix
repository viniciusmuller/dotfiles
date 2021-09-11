{ pkgs, ... }:

let
  vim-test = {
    plugin = pkgs.vimPlugins.vim-test;
    config = ''
      nnoremap <leader>ts :TestSuite<cr>
      nnoremap <leader>tn :TestNearest<cr>
      nnoremap <leader>tf :TestFile<cr>
      nnoremap <leader>tv :TestVisit<cr>
      nnoremap <leader>tl :TestLast<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ vim-test ];
}
