{ pkgs, ... }:

let
  indentline = {
    plugin = pkgs.vimPlugins.indent-blankline-nvim;
    config = "let g:indent_blankline_char = '│'";
  };
in
{
  programs.neovim.plugins = [ indentline ];
}
