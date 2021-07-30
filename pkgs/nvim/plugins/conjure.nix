{ pkgs, ... }:

let
  conjure = {
    plugin = pkgs.vimPlugins.conjure;
    config = ''

    '';
  };
in
{
  programs.neovim.plugins = [ conjure ];
}
