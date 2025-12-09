{ pkgs, prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    vim.lsp.config('nil_ls', {
      on_attach = on_attach,
      capabilities = capabilities
    })
  '';
}
