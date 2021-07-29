{ pkgs, ... }:

let
  tokyonight = {
    plugin = pkgs.vimPlugins.tokyonight-nvim;
    config = ''
      colorscheme tokyonight
    '';
  };
in
{
  programs.neovim.plugins = [ tokyonight ];
}
