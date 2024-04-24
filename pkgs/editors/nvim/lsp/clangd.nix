{ prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').clangd.setup {
      on_attach = on_attach,
      capabitilies = capabitilies
    }
  '';
}
