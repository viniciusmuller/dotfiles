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
    nodePackages.typescript-language-server
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').tsserver.setup{
      on_attach = on_attach
    }
  '';
}
