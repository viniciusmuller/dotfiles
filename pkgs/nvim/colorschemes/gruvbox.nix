{ pkgs, ... }:

let
  gruvbox = {
    plugin = pkgs.vimPlugins.gruvbox-nvim;
    config = ''
      set bg=dark
      let g:gruvbox_italic = 1
      let g:gruvbox_contrast_dark = "medium"
      colorscheme gruvbox
    '';
  };
in
{
  programs.neovim.plugins = [ gruvbox ];
}
