{ pkgs, ... }:


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
  home.packages = with pkgs; [
    rnix-lsp
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
  require('lspconfig').rnix.setup{
    on_attach = on_attach
  }
  '';
}
