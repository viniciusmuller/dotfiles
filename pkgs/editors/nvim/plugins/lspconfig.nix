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

      vim.cmd[[
        augroup lsp
          " TODO: Make this autocommand only run in <buffer>
          autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
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

        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

        -- buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>', opts)

        -- This line requires trouble-nvim
        -- buf_set_keymap('n', '<leader>lq', '<cmd>LspTrouble<cr>', opts)
        buf_set_keymap('n', '<space>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
        buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      end
    '';
  };
in
{
  programs.neovim.plugins = [ lspconfig ];
}
