{ pkgs, prelude, ... }:

with pkgs;
{
  home.packages = [
    ccls
  ];

  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').ccls.setup {
      on_attach = on_attach,
      capabitilies = capabitilies
    }
  '';
}
