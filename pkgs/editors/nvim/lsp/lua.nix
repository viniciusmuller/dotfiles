{ pkgs, prelude, ... }:

with pkgs;
{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').sumneko_lua.setup {
      cmd = {'lua-language-server'};
      on_attach = on_attach,
      capabilities = capabilities

      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  '';
}
