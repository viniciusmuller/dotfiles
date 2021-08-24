{ pkgs, prelude, ... }:

{
  # TODO: Make a prelude with these helper functions
  programs.neovim = {
    extraConfig = prelude.mkLuaCode ''
      require('lspconfig').gdscript.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        }
      }
    '';
  };
}
