{ pkgs, ... }:

let
  rainbow = {
    plugin = pkgs.vimPlugins.rainbow;
    config = ''
      let g:rainbow_active = 1
    '';
  };
in
{
  programs.neovim.plugins = [ rainbow ];
}
