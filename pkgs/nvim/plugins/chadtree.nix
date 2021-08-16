{ pkgs, ... }:

let
  chadtree = {
    plugin = pkgs.vimPlugins.chadtree;
    config = "let g:chadtree_settings = {'xdg': v:true}";
  };
in
{
  programs.neovim.plugins = [ chadtree ];
}
