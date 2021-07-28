{ pkgs, ... }:

let
  projectionist = {
    plugin = pkgs.vimPlugins.vim-projectionist;
    config = "nnoremap <silent> <leader>pa :A<cr>";
  };
in
{
  programs.neovim.plugins = [ projectionist ];
}
