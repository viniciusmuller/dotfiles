{ pkgs, prelude, ... }:

{
  programs.neovim = {
    extraConfig = ''
        ${prelude.mkLuaCode ''
        vim.lsp.config('gopls', {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          }
        })
      ''}
    '';
  };
}
