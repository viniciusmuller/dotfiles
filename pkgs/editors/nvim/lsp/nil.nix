{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').nil_ls.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
