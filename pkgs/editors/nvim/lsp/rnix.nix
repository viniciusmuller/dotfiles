{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').rnix.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
