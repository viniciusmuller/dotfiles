{ pkgs, prelude, ... }:

{
  home.packages = [
    pkgs.clojure-lsp
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').clojure_lsp.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
