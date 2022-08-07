{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').erlangls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
    }
  '';
}
