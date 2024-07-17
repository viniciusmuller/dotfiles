{ prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    local cmd = "/home/vini/projects/rust/open-source/test-ls/target/release/project-name"

    local test_ls = {
      cmd = { cmd },
      filetypes = { "elixir", "eelixir", "heex", "surface" },
      settings = {},
    }

    configs.test_ls = {
      default_config = {
        cmd = test_ls.cmd,
        filetypes = test_ls.filetypes,
        settings = test_ls.settings,
      },
    }

    local function endswith(str, suffix)
      return string.sub(str, -#suffix) == suffix
    end

    lspconfig.test_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function(fname)
        local project = lspconfig.util.root_pattern(".git")(fname)
        return project
      end
    })

    -- log config
    require("vim.lsp.log").set_format_func(vim.inspect)
    vim.lsp.set_log_level("debug")
  '';
}
