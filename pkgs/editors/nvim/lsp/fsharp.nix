{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').fsautocomplete.setup{
      on_attach = on_attach,
      capabilities = capabilities,
    }
  '';
}
