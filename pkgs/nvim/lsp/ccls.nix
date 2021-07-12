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
    ccls
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').ccls.setup {
      on_attach = on_attach,
    }
  '';
}
