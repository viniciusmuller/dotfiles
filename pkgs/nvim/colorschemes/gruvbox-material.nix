{ pkgs, ... }:

let
  gruvbox-material = {
    plugin = pkgs.vimPlugins.gruvbox-material;
    config = ''
      set bg=dark
      let g:gruvbox_material_background = 'hard'
      let g:gruvbox_material_enable_italic = 1
      colorscheme gruvbox-material
    '';
  };
in
{
  programs.neovim.plugins = [ gruvbox-material ];
}
