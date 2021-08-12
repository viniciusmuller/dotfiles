{ pkgs, ... }:

let
  vim-splitjoin = {
    plugin = pkgs.vimPlugins.splitjoin-vim;
    config = ''
      let g:splitjoin_align = 1
    '';
  };
in
{
  programs.neovim.plugins = [ vim-splitjoin ];
}
