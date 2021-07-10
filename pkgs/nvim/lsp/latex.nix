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
  home.packages = [ pkgs.texlab ];
  programs.neovim.extraConfig = mkLuaCode ''
    require'lspconfig'.texlab.setup{
      on_attach = on_attach
    }
  '';
}
