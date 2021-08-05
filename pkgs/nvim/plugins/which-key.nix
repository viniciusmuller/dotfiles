{ pkgs, prelude, ... }:

let
  which-key = {
    plugin = pkgs.vimPlugins.which-key-nvim;
    config = prelude.mkLuaCode ''
      require('which-key').setup{}
    '';
  };
in
{
  programs.neovim.plugins = [ which-key ];
}
