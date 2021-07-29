{ pkgs, ... }:

let
  tokyonight = {
    plugin = tokyonight-nvim;
    config = ''
      colorscheme tokyonight
    '';
  };
in
{
  programs.neovim.plugins = [ tokyonight ];
}
