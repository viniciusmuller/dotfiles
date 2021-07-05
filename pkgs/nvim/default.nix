{ pkgs, ... }:

with pkgs.vimPlugins;
let
  mkLuaCode =
    (code:
      ''
        lua << EOF
          ${code}
        EOF
      '');

  my-gitsigns = {
    plugin = gitsigns-nvim;
    config = ''
      nnoremap <leader>gm <cmd>lua require('gitsigns').blame_line(true)<cr>

      ${mkLuaCode ''
          require('gitsigns').setup{}
      ''}
    '';
  };

  my-vim-test = {
    plugin = vim-test;
    config = ''
      nnoremap <leader>ts :TestSuite<cr>
      nnoremap <leader>tn :TestNearest<cr>
      nnoremap <leader>tf :TestFile<cr>
      nnoremap <leader>tv :TestVisit<cr>
      nnoremap <leader>tl :TestLast<cr>
    '';
  };

  my-fugitive = {
    plugin = vim-fugitive;
    config = ''
      nnoremap <silent> <Leader>G :tab G<cr>
      nnoremap <silent> <Leader>gd :Gvdiffsplit<cr>
      nnoremap <silent> <Leader>gD :!git diff<cr>
      nnoremap <silent> <Leader>gl :Gclog<cr>
    '';
  };

  my-projectionist = {
    plugin = vim-projectionist;
    config = "nnoremap <silent> <leader>pa :AV<cr>";
  };

  my-quickrun = {
    plugin = vim-quickrun;
    config = "nnoremap <leader>qr :QuickRun<cr>";
  };

  my-trouble = {
    plugin = trouble-nvim;
    config = "lua require('trouble').setup{}";
  };

  my-todo-comments = {
    plugin = todo-comments-nvim;
    config = ''
      nnoremap <leader>pt <cmd>TodoQuickFix<cr>
      ${mkLuaCode "require('todo-comments').setup{}"}
    '';
  };

  my-compe = {
    plugin = nvim-compe;
    config = ''
      " Keybindings
      inoremap <silent><expr> <C-space> compe#complete()
      inoremap <silent><expr> <cr>      compe#confirm('<CR>')
      inoremap <silent><expr> <C-e>     compe#close('<C-e>')
      inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
      inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
      inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
      inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

      ${mkLuaCode ''
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
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = true;
            ultisnips = true;
            luasnip = true;
          };
        }
      ''}
    '';
  };

  my-treesitter = {
    plugin = nvim-treesitter;
    config = mkLuaCode ''
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]e"] = "@class.outer",
            },
            -- goto_next_end = {
            --  ["]M"] = "@function.outer",
            --  ["]["] = "@class.outer",
            -- },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[e"] = "@class.outer",
            },
            -- goto_previous_end = {
            --  ["[M"] = "@function.outer",
            --  ["[]"] = "@class.outer",
            -- },
          },
        }
      }
    '';
  };

  # TODO: Figure out how to make this work
  my-tokyonight-nvim =
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "tokyonight.nvim";
        version = "2021-07-04";

        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "0ead86afe390603f9bd688103d7a5fc6724a828e";
          sha256 = "1l6hscamapmqjn1kc2hrpynwwrljdlp84g27282wfvc2i0kpj884";
        };

        meta.homepage = "https://github.com/folke/tokyonight.nvim";
      };

      config = "colorscheme tokyonight";
    };

  my-vim-tmux-navigator =
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "vim-tmux-navigator";
        version = "2021-07-04";

        src = pkgs.fetchFromGitHub {
          owner = "christoomey";
          repo = "vim-tmux-navigator";
          rev = "0xxc5wpyfqv7f7sfy6xncy7ipj0cvshw28s12ld3jfgyimjllr62";
          sha256 = "0xxc5wpyfqv7f7sfy6xncy7ipj0cvshw28s12ld3jfgyimjllr62";
        };

        meta.homepage = "https://github.com/christoomey/vim-tmux-navigator";
      };
    };

  my-blamer = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "blamer.nvim";
      version = "2021-07-04";

      src = pkgs.fetchFromGitHub {
        owner = "APZelos";
        repo = "blamer.nvim";
        rev = "12f8eea7586a91ea1994501722d2e1575d9c6b63";
        sha256 = "017x2x93g4wscw7s0m5dqhsf8hb0iv4jczbyc82mkdx8f6xg963v";
      };

      meta.homepage = "https://github.com/APZelos/blamer.nvim";
    };

    config = ''
      let g:blamer_enabled = 1
      let g:blamer_delay = 200
      let g:blamer_show_in_visual_modes = 0
      let g:blamer_relative_time = 1
    '';
  };

  my-telescope-nvim = {
    plugin = telescope-nvim;
    config = ''
      nnoremap <C-e>       <cmd>Telescope git_files<cr>
      nnoremap <leader>ff  <cmd>Telescope find_files<cr>
      nnoremap <leader>fs  <cmd>Telescope live_grep<cr>
      nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
      nnoremap <leader>fb  <cmd>Telescope buffers<cr>
      nnoremap <leader>fm  <cmd>Telescope man_pages<cr>
    '';
  };

  my-lspconfig = {
    plugin = nvim-lspconfig;
    config = ''
      " Prettier LSP diagnostic symbols
      sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
      sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
      sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
      sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

      " TODO: Not working
      " autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})

      ${mkLuaCode ''
        -- This function needs to be global, so that other lsp configs inside
        -- ./lsp will be able to reference it in their setup.
        _G.on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          -- Enable completion triggered by <c-x><c-o>
          -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap=true, silent=true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions

          buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
          buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
          buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)

          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>', opts)
          buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

          buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>', opts)
          buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
          buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
          buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end
      ''}
    '';
  };

  my-lualine = {
    plugin = lualine-nvim;
    config = mkLuaCode ''
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = {'', ''},
          section_separators = {'', ''},
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            {'diagnostics', sources = {'nvim_lsp'}}
          },
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    '';
  };

  my-ultisnips = {
    plugin = ultisnips;
    config = ''
      let g:UltiSnipsJumpForwardTrigger="<C-j>"
      let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    '';
  };
in
{
  imports = [
    ./lsp/elixir.nix
    ./lsp/haskell.nix
    ./lsp/node.nix
    ./lsp/rnix.nix
    ./lsp/rust.nix
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # Language specific
      vim-nix

      # Utils
      my-vim-tmux-navigator
      my-projectionist
      vim-commentary
      vim-sensible
      vim-surround
      vim-repeat
      auto-pairs
      # vim-mkdir
      targets-vim
      my-quickrun

      # Snippets
      vim-snippets
      my-ultisnips

      # Neovim lua things
      plenary-nvim
      my-treesitter
      nvim-treesitter-textobjects
      my-telescope-nvim
      my-lspconfig
      my-compe
      # my-trouble
      my-todo-comments

      # Git
      my-gitsigns
      my-fugitive
      my-blamer

      # Aesthetic
      nvim-web-devicons
      my-tokyonight-nvim
      my-lualine
    ];

    extraConfig = ''
      map <space> \

      set number relativenumber
      set expandtab tabstop=2 shiftwidth=2
      set cursorline
      set termguicolors
      set colorcolumn=80 " Ruler
      set nofoldenable
      set showcmd
      set ignorecase smartcase
      set listchars=tab:\|\ ,space:·
      set list
      set textwidth=80
      set sessionoptions+=globals
      set hidden
      set guifont=JetBrains\ Mono:h12
      set wildignorecase
      set linebreak
      set autoindent
      set smartindent
      set splitright
      set scrolloff=5
      set lazyredraw
      set noswapfile
      set autoread

      noremap Y "+y
      nnoremap <C-s> :update<cr>
      nnoremap H ^
      nnoremap L $
      nnoremap <C-q> <C-w>q

      " Marks
      nnoremap <C-g> `
      nnoremap <C-g><C-g>  `"

      augroup my_autocommands
        " Remove trailing whitespaces on write
        au BufWritePre * %s/\s\+$//e
        " Open help windows vertically splitted
        au FileType help wincmd L
      augroup end
    '';
  };

  home.packages = with pkgs; [
    neovide
    tree-sitter
  ];

  programs.bash.shellAliases = {
    v = "nvim";
  };
}

