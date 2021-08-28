{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require'lspconfig'.texlab.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
