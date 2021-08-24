{ pkgs, prelude, ... }:

with pkgs;
{
  home.packages = [
    ccls
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').ccls.setup {
      on_attach = on_attach,
      capabitilies = capabitilies
    }
  '';
}
