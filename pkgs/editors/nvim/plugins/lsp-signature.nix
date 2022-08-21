{ pkgs, prelude, ... }:

let
  lsp-signature = {
    plugin = pkgs.vimPlugins.lsp_signature-nvim;
    config = prelude.mkLuaCode "require('lsp_signature').setup()";
  };
in
{
  programs.neovim.plugins = [ lsp-signature ];
}
