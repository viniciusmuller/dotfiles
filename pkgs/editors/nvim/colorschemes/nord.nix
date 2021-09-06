{ pkgs, ... }:

let
  nord = {
    plugin = pkgs.vimPlugins.nord-vim;
    config = ''
      colorscheme nord
    '';
  };
in
{
  programs.neovim.plugins = [ nord ];
}
