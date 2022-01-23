{ pkgs, prelude, ... }:


let
  cmp = {
    plugin = pkgs.vimPlugins.nvim-cmp;

    config = prelude.mkLuaCode ''
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

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

      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lsp_symbols[vim_item.kind]
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
            })[entry.source.name]

            return vim_item
          end
        },
        snippet = {
          expand = function(args)
             require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = {
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    '';
  };
  cmp-engines = with pkgs.vimPlugins; [
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp_luasnip
  ];
in
{
  imports = [ ./luasnip.nix ];

  programs.neovim.plugins = [
    cmp
  ] ++ cmp-engines;
}
