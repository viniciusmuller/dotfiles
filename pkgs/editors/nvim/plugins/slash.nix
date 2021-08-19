{ pkgs, ... }:

let
  slash = {
    plugin = pkgs.vimPlugins.vim-slash;
    config = ''
      noremap <plug>(slash-after) zz
    '';
  };
in
{
  programs.neovim.plugins = [ slash ];
}
