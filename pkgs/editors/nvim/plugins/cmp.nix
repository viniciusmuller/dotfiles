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

  # path = "3.5.54/x86_64-unknown-linux-musl";
  # tabnine-binaries = pkgs.fetchurl {
  #   url = "https://update.tabnine.com/bundles/${path}/TabNine.zip";
  #   sha256 = "sha256-MgvDO1E8gvAPnKtn1095p4I1vt298J87V4+dAp55AKs=";
  # };

  # cmp-tabnine = pkgs.vimUtils.buildVimPlugin {
  #     name = "cmp-tabnine";
  #     version = "2021-07-19";

  #     src = pkgs.fetchFromGitHub {
  #       owner = "tzachar";
  #       repo = "cmp-tabnine";
  #       rev = "906ab3615bb9e9562419193a94e5c87113368d14";
  #       sha256 = "sha256-TTPvA8QIHIHfMs+TbHrYZQXKIlH8vpXsa3dKELRf4Wk=";
  #     };

  #     # TODO Make this bad boy work
  #     patchPhase = ''
  #       rm install.sh
  #     '';

  #     buildPhase = ''
  #       mkdir -p binaries/${path}
  #       cp ${tabnine-binaries} binaries/${path}/TabNine.zip
  #       unzip -o binaries/${path}/TabNine.zip -d binaries/${path}
  #       rm binaries/${path}/TabNine.zip
  #       chmod +x binaries/${path}/*
  #     '';

  #     buildInputs = with pkgs; [unzip];

  #     meta.homepage = "https://github.com/tzachar/cmp-tabnine";
  #   };

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
        completion = {
          completeopt = 'menu,menuone,noinsert',
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
          -- { name = 'cmp_tabnine' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }

      -- local tabnine = require('cmp_tabnine.config')
      -- tabnine:setup({
      --  max_lines = 1000;
      --  max_num_results = 20;
      --  sort = true;
      -- })
    '';
  };
  compe-engines = with pkgs.vimPlugins; [
    my-cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-vsnip
    # cmp-tabnine
    # my-cmp-nvim-lsp
  ];
in
{
  programs.neovim.plugins = [
    cmp
  ] ++ compe-engines;
}
