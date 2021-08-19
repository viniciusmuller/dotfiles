{ pkgs, ... }:

let
  lsp-signature = {
    plugin = pkgs.vimPlugins.lsp_signature-nvim;
    config = "lua require('lsp_signature').setup()";
  };
in
{
  programs.neovim.plugins = [ lsp-signature ];
}
