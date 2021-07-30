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
    clojure-lsp
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').clojure_lsp.setup {
      on_attach = on_attach,
    }
  '';
}
