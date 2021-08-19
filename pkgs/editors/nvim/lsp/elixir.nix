{ pkgs, prelude, ... }:

{
  home.packages = [
    pkgs.elixir_ls
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').elixirls.setup{
      on_attach = on_attach,
      cmd = { "elixir-ls" };
    }
  '';
}
