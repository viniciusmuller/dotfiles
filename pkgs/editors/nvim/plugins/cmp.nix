{ pkgs, prelude, ... }:


let
  cmp = {
    plugin = pkgs.vimPlugins.nvim-cmp;

    config = prelude.mkLuaCode ''
      local cmp = require('cmp')

      local lsp_symbols = {
        Text = "  (Text) ",
        Method = "  (Method)",
        Function = "  (Function)",
        Constructor = "  (Constructor)",
        Field = "ﴲ  (Field)",
        Variable = " (Variable)",
        Class = "  (Class)",
        Interface = "ﰮ  (Interface)",
        Module = "  (Module)",
        Property = "襁 (Property)",
        Unit = "  (Unit)",
        Value = "  (Value)",
        Enum = "練 (Enum)",
        Keyword = "  (Keyword)",
        Snippet = "  (Snippet)",
        Color = "  (Color)",
        File = "  (File)",
        Reference = "  (Reference)",
        Folder = "  (Folder)",
        EnumMember = "  (EnumMember)",
        Constant = " ﲀ  (Constant)",
        Struct = "ﳤ  (Struct)",
        Event = "  (Event)",
        Operator = "  (Operator)",
        TypeParameter = "  (TypeParameter)",
      }

      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lsp_symbols[vim_item.kind]
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              vsnip = "[Vsnip]",
            })[entry.source.name]

            return vim_item
          end
        },
        snippet = {
          expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
          end
        },
        mapping = {
            ['<Tab>'] = function(fallback)
              if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
              elseif vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), ''')
              else
                fallback()
              end
            end,
            ['<S-Tab>'] = function(fallback)
              if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
              elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), ''')
              else
                fallback()
              end
            end,
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
        },
        sources = {
          { name = 'vsnip', },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    '';
  };
  compe-engines = with pkgs.vimPlugins; [
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-vsnip
  ];
in
{
  programs.neovim.plugins = [
    cmp
  ] ++ compe-engines;
}
