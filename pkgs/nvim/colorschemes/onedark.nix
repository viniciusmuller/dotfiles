{ pkgs, ... }:

let
  onedark = {
    plugin = pkgs.vimPlugins.onedark-nvim;
    config = ''
      colorscheme onedark_nvim
    '';
  };
in
{
  programs.neovim.plugins = [ pkgs.vimPlugins.lush-nvim onedark ];
}
