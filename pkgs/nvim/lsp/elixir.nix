{ pkgs, ... }:

with pkgs;
let
  mkLuaCode =
    (code:
      ''
        lua << EOF
          ${code}
        EOF
      '');
in
{
  home.packages = [
    elixir_ls
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').elixirls.setup{
      on_attach = on_attach,
      cmd = { "elixir-ls" };
    }
  '';
}
