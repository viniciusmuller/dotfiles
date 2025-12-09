{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').tsserver.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
