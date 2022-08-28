{ pkgs, lib, ... }:

let
  improved-darkblue = {
    plugin = pkgs.writeText "improved-dark-blue" "";
    config = ''
      colorscheme darkblue " Vim's default
      highlight CursorLine guibg=#001f6e
      highlight ColorColumn guibg=#001f6e
      highlight! Folded guifg=#c0c0c0 guibg=#404080
      highlight! FoldColumn guifg=#c0c0c0 guibg=#404080
    '';
  };
in
{
  programs.neovim.plugins = lib.mkBefore [ improved-darkblue ];
}
