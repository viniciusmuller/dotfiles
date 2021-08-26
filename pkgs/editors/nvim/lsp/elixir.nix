{ pkgs, prelude, ... }:

{
  home.packages = [
    pkgs.elixir_ls
  ];

  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').elixirls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "elixir-ls" };
    }
  '';
}
