{ pkgs, prelude, ... }:

with pkgs;
{
  home.packages = [
    nodePackages.typescript-language-server
  ];

  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').tsserver.setup{
      on_attach = on_attach
    }
  '';
}
