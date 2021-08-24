{ pkgs, prelude, ... }:

{
  home.packages = [ pkgs.texlab ];
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require'lspconfig'.texlab.setup{
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
