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
    rust-analyzer
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').rust_analyzer.setup{
      on_attach = on_attach
    }
  '';
}
