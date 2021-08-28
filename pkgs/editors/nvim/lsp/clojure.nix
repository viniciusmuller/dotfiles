{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').clojure_lsp.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
