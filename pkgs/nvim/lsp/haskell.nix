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
  home.packages = [ pkgs.haskell-language-server ];
  programs.neovim.extraConfig = mkLuaCode ''
    require'lspconfig'.hls.setup{
      on_attach = on_attach
    }
  '';
}
