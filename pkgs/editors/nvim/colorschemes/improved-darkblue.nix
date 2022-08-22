{ pkgs, lib, ... }:

let
  leader-mappings = {
    plugin = pkgs.writeText "improved-dark-blue" "";
    config = ''
      colorscheme darkblue " Vim's default
      highlight CursorLine guibg=#001f6e
      highlight ColorColumn guibg=#001f6e
    '';
  };
in
{
  # foo bar
  programs.neovim.plugins = lib.mkBefore [ leader-mappings ];
}
