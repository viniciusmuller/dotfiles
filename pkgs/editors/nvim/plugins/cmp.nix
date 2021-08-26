{ pkgs, prelude, ... }:


let
  # TODO: Wait for this to update in nixpkgs upstream
  my-cmp-nvim-lsp = pkgs.vimUtils.buildVimPlugin {
      name = "my-cmp-nvim-lsp";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "cmp-nvim-lsp";
        rev = "6d991d0f7beb2bfd26cb0200ef7bfa6293899f23";
        sha256 = "sha256-syK4yHYioE58zt0pPDZxLOZKyAkKEPzB3XSNwrkGCHs=";
      };

      meta.homepage = "https://github.com/hrsh7th/cmp-nvim-lsp";
    };

  cmp = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-cmp";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-cmp";
        rev = "fe964405ff25ea63a9c12c26e41edf95066dad7c";
        sha256 = "sha256-900AN1Dt2X8LuIPgmc/2U7uqAnPiOKxyQPOtU1SWK+U=";
      };

      prePatch = "rm Makefile";
      meta.homepage = "https://github.com/hrsh7th/nvim-cmp";
    };

    config = prelude.mkLuaCode ''
      local cmp = require('cmp')

      cmp.setup {
        -- completion = {
        --   autocomplete = { ... },
        -- },
        -- sorting = {
        --   priority_weight = 2.,
        --   comparators = { },
        -- },
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
              elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), ''')
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
    cmp-buffer
    cmp-path
    cmp-vsnip
    # my-cmp-nvim-lsp
  ];
in
{
  programs.neovim.plugins = [
    cmp
    my-cmp-nvim-lsp
  ] ++ compe-engines;
}
