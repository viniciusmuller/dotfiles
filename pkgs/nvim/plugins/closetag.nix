{ pkgs, ... }:

let
  closetag = {
    plugin = pkgs.vimPlugins.vim-closetag;
    config = ''
      " https://github.com/alvan/vim-closetag#usage
       let g:closetag_filenames = '*.html,*.tsx,*.jsx'
    '';
  };
in
{
  programs.neovim.plugins = [ closetag ];
}
