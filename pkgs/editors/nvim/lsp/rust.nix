{ pkgs, prelude, ... }:

with pkgs;
{
  home.packages = [
    rust-analyzer
  ];

  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').rust_analyzer.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
