{ pkgs, ... }:

let
  dracula = {
    plugin = pkgs.vimPlugins.dracula-vim;
    config = ''
      colorscheme dracula
      hi Cursorline guibg=Gray
    '';
  };
in
{
  programs.neovim.plugins = [ dracula ];
}
