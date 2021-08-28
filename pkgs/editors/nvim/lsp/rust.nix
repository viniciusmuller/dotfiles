{ pkgs, prelude, ... }:

with pkgs;
{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').rust_analyzer.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          -- procMacro = { enable = true },
          -- cargo = { loadOutDirsFromCheck = true }
          -- TODO: Couldn't get proc macros to work
          diagnostics = { disabled = { "unresolved-proc-macro" } }
        }
      }
    }
  '';
}
