{ pkgs, ... }:

let
  mkLuaCode =
    (
      code:
      ''
        lua << EOF
          ${code}
        EOF
      ''
    );

  which-key = {
    plugin = pkgs.vimPlugins.which-key-nvim;
    config = mkLuaCode ''
      require('which-key').setup{}
    '';
  };
in
{
  programs.neovim.plugins = [ which-key ];
}
