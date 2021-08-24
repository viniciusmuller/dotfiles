{ pkgs, prelude, ... }:

with pkgs;
{
  home.packages = [
    rust-analyzer
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').rust_analyzer.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
