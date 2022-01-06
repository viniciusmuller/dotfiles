{ pkgs, prelude, ... }:

let
  lspconfig = {
    plugin = pkgs.vimPlugins.nvim-lspconfig;
    config = prelude.mkLuaCode ''
      -- Disable virtual text diagnostics
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = false,
          signs = true,
          update_in_insert = true,
          underline = true,
        }
      )

      -- Diagnostic signs
      local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
      for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Add borders to lsp hover and signature popups 
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = "single"
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
          border = "single"
        }
      )

      vim.cmd[[
        augroup lsp
          autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})
        augroup end
      ]]

      -- This function needs to be global, so that other lsp configs inside
      -- ./lsp will be able to reference it in their setup.
      _G.on_attach = function(client, bufnr)

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        vim.wo.signcolumn = 'yes'

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions

        -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
        -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
        -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)

        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>', opts)

        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

        -- buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>', opts)

        buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
        buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.workspace_symbol("")<cr>', opts)
        buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end

      -- Lsp capabilities
      _G.capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities.textDocument.codeAction = {
          dynamicRegistration = true,
          codeActionLiteralSupport = {
              codeActionKind = {
                  valueSet = (function()
                      local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                      table.sort(res)
                      return res
                  end)()
              }
          }
      }

      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          'documentation',
          'detail',
          'additionalTextEdits',
        }
      }
    '';
  };
in
{
  programs.neovim.plugins = [
    lspconfig
  ];
}
