{ pkgs, ... }:

let
  projectionist = {
    plugin = pkgs.vimPlugins.vim-projectionist;
    config = "nnoremap <leader>pa <cmd>A<cr>";
  };
in
{
  programs.neovim.plugins = [ projectionist ];
}
