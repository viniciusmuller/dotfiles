{ pkgs, ... }:

let
  visual-multi = {
    plugin = pkgs.vimPlugins.vim-visual-multi;
    config = ''
      let g:VM_reselect_first = 1
    '';
  };
in
{
  programs.neovim.plugins = [ visual-multi ];
}
