{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require'lspconfig'.hls.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
