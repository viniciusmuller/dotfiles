{ pkgs, prelude, ... }:

let
  fidget-nvim = {
    plugin = pkgs.vimPlugins.fidget-nvim;
    config = prelude.mkLuaCode ''
      require("fidget").setup({})
    '';
  };
in
{
  programs.neovim.plugins = [ fidget-nvim ];
}
