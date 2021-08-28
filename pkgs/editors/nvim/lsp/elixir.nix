{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').elixirls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "elixir-ls" };
    }
  '';
}
