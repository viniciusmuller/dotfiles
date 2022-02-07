{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    -- require('lspconfig').pylsp.setup{
      -- cmd = {'pyls'},
      -- on_attach = on_attach,
      -- capabilities = capabilities
    -- }

    require('lspconfig').jedi_language_server.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
  '';
}
