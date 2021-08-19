{ pkgs, ... }:

let
  onedark = {
    plugin = pkgs.vimPlugins.onedark-nvim;
    config = ''
      colorscheme onedark_nvim
      hi Cursorline guibg=#222429
    '';
  };
in
{
  programs.neovim.plugins = [ onedark ];
}
