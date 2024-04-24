{ pkgs, prelude, ... }:

with pkgs;
{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').zls.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
