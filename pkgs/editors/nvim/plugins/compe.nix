{ pkgs, prelude, ... }:

let
  compe = {
    plugin = pkgs.vimPlugins.nvim-compe;
    config = ''
        " Keybindings
        " inoremap <silent><expr> <C-space> compe#complete()
        " inoremap <silent><expr> <cr>      compe#confirm('<CR>')
        " inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
        " inoremap <silent><expr> <C-e>     compe#close('<C-e>')
        " inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
        " inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

        " inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
        " inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

        ${prelude.mkLuaCode ''
        require('compe').setup {
          enabled = true;
          autocomplete = true;
          debug = false;
          min_length = 1;
          preselect = 'always';
          throttle_time = 80;
          max_abbr_width = 100;
          max_kind_width = 100;
          max_menu_width = 100;
          documentation = true;

          source = {
            emoji = true;
            path = true;
            buffer = true;
            calc = true;
            spell = true;
            orgmode = true;
            nvim_lsp = true;
            nvim_lua = true;
            ultisnips = true;
            luasnip = true;
            vsnip = {priority = 100000};
            neorg = true;
          };
        }

        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local check_back_space = function()
            local col = vim.fn.col('.') - 1
            if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                return true
            else
                return false
            end
        end

        _G.tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
          elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
          elseif check_back_space() then
            return t "<Tab>"
          else
            return vim.fn['compe#complete']()
          end
        end

        _G.s_tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
          elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
          else
            return t "<S-Tab>"
          end
        end

        vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      ''}
    '';
  };
in
{
  programs.neovim.plugins = [ compe ];
}
