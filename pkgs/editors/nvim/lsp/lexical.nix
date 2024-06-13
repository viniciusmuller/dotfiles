{ prelude, ... }:

{
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    local cmd = "lexical"

    local lexical = {
      cmd = { cmd },
      filetypes = { "elixir", "eelixir", "heex", "surface" },
      settings = {},
    }

    configs.lexical = {
      default_config = {
        cmd = lexical.cmd,
        filetypes = lexical.filetypes,
        settings = lexical.settings,
      },
    }

    local function endswith(str, suffix)
      return string.sub(str, -#suffix) == suffix
    end

    lspconfig.lexical.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function(fname)
        local project = lspconfig.util.root_pattern(".git")(fname)

        if project and endswith(project, "open-source/lexical") then
          return project
        else
          return lspconfig.util.root_pattern("mix.exs", ".git")(fname)
        end
      end
    })

    -- log config
    require("vim.lsp.log").set_format_func(vim.inspect)
    vim.lsp.set_log_level("debug")
  '';
}
