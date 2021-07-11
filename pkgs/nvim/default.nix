{ config, pkgs, ... }:

with pkgs.vimPlugins;
let
  mkLuaCode =
    (
      code:
        ''
          lua << EOF
            ${code}
          EOF
        ''
    );

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
      let test#strategy = "neovim"

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
      nnoremap <silent> <Leader>gg :tab G<cr>
      nnoremap <silent> <Leader>gd :Gvdiffsplit<cr>
      nnoremap <silent> <Leader>gD :!git diff<cr>
      nnoremap <silent> <Leader>gl :Gclog<cr>
    '';
  };

  my-projectionist = {
    plugin = vim-projectionist;
    config = "nnoremap <silent> <leader>pa :A<cr>";
  };

  my-quickrun = {
    # plugin = vim-quickrun;
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-quickrun";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "thinca";
        repo = "vim-quickrun";
        rev = "581b44800dddd01b69669257787e05ccbb6a21cc";
        sha256 = "LZMJhJ0A3tLn1g8SbCePWbiwqHtafLvDPvMGkhzYvzQ=";
      };

      meta.homepage = "https://github.com/thinca/vim-quickrun";
    };

    config = "nnoremap <leader>qr <cmd>QuickRun<cr>";
  };

  my-trouble = {
    plugin = trouble-nvim;
    config = ''
      nnoremap tt <cmd>TroubleToggle<cr>
      lua require('trouble').setup{}
    '';
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
      " inoremap <silent><expr> <cr>      compe#confirm('<CR>')
      " inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
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
          emoji = true;
          path = true;
          buffer = true;
          calc = true;
          spell = true;
          nvim_lsp = true;
          nvim_lua = true;
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

      config = ''
        colorscheme tokyonight
      '';
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

  my-telescope = {
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

      ${mkLuaCode ''

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
          buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

          buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<cr>', opts)
          -- This line requires trouble-nvim
          buf_set_keymap('n', '<leader>lq', '<cmd>LspTrouble<cr>', opts)
          buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
          buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end
      ''}
    '';
  };

  my-listtoggle = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "listtoggle.vim";
      version = "2021-07-06";

      src = pkgs.fetchFromGitHub {
        owner = "Valloric";
        repo = "ListToggle";
        rev = "63fb8acb57d57380b2e30e7a831247140559c95f";
        sha256 = "1fbshc3pjm0d1nnig2wnbj9yf39iagva44k2qhl85zfz1pv7sv57";
      };

      meta.homepage = "https://github.com/Valloric/ListToggle";
    };

    config = ''
      let g:lt_location_list_toggle_map = 'tl'
      let g:lt_quickfix_list_toggle_map = 'tq'
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
      let g:UltiSnipsExpandTrigger="<M-j>"
      let g:UltiSnipsJumpForwardTrigger="<C-j>"
      let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    '';
  };

  my-indentline = {
    plugin = indent-blankline-nvim;
    config = "let g:indent_blankline_char = '│'";
  };

  my-fzf = {
    plugin = fzf-vim;
    config = ''
      let $FZF_DEFAULT_COMMAND = 'fd -H'
      let $FZF_DEFAULT_OPTS = '--exact --reverse'
      let g:fzf_preview_window = ['right:50%', 'ctrl-/']

      " TODO: Create other keybindings like `<leader>;` for very used commands
      nnoremap <leader>.   <cmd>GFiles<cr>
      nnoremap <leader>,   <cmd>Buffers<cr>
      nnoremap <leader>ff  <cmd>Files<cr>
      nnoremap <leader>fc  <cmd>Commits<cr>
      nnoremap <leader>fs  <cmd>Rg<cr>
      nnoremap <leader>fh  <cmd>Helptags<cr>
      nnoremap <leader>fm  <cmd>Apropos<cr>

      " Rg with --hidden
      command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)

      command! -nargs=? Apropos call fzf#run(fzf#wrap({'source': 'apropos .'.shellescape(<q-args>).' | cut -d " " -f 1', 'sink': 'tab Man', 'options': ['--preview', 'MANPAGER=cat MANWIDTH='.(&columns/2-4).' man {}']}))
    '';
  };

  my-fzf-checkout = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "fzf-checkout.vim";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "stsewd";
        repo = "fzf-checkout.vim";
        rev = "4d5ecae74460de8fed4f743f6bd53c4c31d32797";
        sha256 = "0mia7p2z8l3lrid0v8ml4i8y190gh4ll9898yyg4gcghhxp83zpm";
      };

      # The plugin has a makefile which tries to run a docker container. This
      # fixes it.
      prePatch = ''
        rm Makefile
      '';

      meta.homepage = "https://github.com/stsewd/fzf-checkout.vim";
    };

    config = ''
      let g:fzf_checkout_git_options = '--sort=-committerdate'
      let g:fzf_tag_actions = {
      \ 'checkout': {'execute': '!{git} -C {cwd} checkout {branch}'},
      \}

      nnoremap <leader>gb <cmd>GBranches<cr>
      nnoremap <leader>gt <cmd>GTags<cr>
    '';
  };

  my-nvim-tree = {
    plugin = nvim-tree-lua;
    config = ''
      let g:nvim_tree_follow = 1
      nnoremap tn <cmd>NvimTreeToggle<cr>
    '';
  };

  my-multiple-cursors = {
    plugin = vim-visual-multi;
    config = ''
      let g:VM_reselect_first = 1
    '';
  };

  my-vim-prettier = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-prettier";
      version = "2021-07-06";

      src = pkgs.fetchFromGitHub {
        owner = "prettier";
        repo = "vim-prettier";
        rev = "0e61e4a5b55d2740aa118db91a6671dcb11307e8";
        sha256 = "0d83lx6kfpsi3d4q9wz8zwsgdn0vn16psqyngml6wspjyibh6pnf";
      };

      # The plugin has a makefile which tries to run a docker container. This
      # fixes it.
      prePatch = ''
        rm Makefile
      '';

      meta.homepage = "https://github.com/prettier/vim-prettier";
    };
  };


  # TODO: Remove highlight when hovering
  my-symbols-outline = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "symbols-outline.nvim";
      version = "2021-07-06";

      src = pkgs.fetchFromGitHub {
        owner = "simrat39";
        repo = "symbols-outline.nvim";
        rev = "631a8880deccf97bfea44d02d70afc8084f49c24";
        sha256 = "06l1i31p04f8cgwsp0vgnjjjbav4jjvv88qx80svfkh6zz5hrbzy";
      };

      meta.homepage = "https://github.com/prettier/vim-prettier";
    };

    config = ''
      nnoremap ts <cmd>SymbolsOutline<cr>
    '';
  };

  my-styled-components = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-styled-components";
      version = "2021-07-06";

      src = pkgs.fetchFromGitHub {
        owner = "styled-components";
        repo = "vim-styled-components";
        rev = "75e178916fc3e61385350933a23055927f5f60b7";
        sha256 = "0rq34sbw58na3y68rrf1b2wbrxpzfg7sk2952plxjmwgbc2zgxkj";
      };

      meta.homepage = "https://github.com/styled-components/vim-styled-components";
    };
  };

  my-nvim-dap = {
    plugin = nvim-dap;
    config = ''
      nnoremap <leader>dd <cmd>lua require('dap').toggle_breakpoint()<cr>
      nnoremap <leader>dD <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
      nnoremap <leader>df <cmd>lua require('dap').continue()<cr>
      nnoremap <leader>dj <cmd>lua require('dap').step_out()<cr>
      nnoremap <leader>dk <cmd>lua require('dap').step_into()<cr>
      nnoremap <leader>dl <cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>
      nnoremap <leader>dr <cmd>lua require('dap').repl.open()<cr>

      ${mkLuaCode ''
      -- require('dap.ext.vscode').load_launchjs()

      local dap = require('dap')

      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = "Launch file";
          program = "''${fileDirname}";
        },
      }

      dap.adapters.python = {
        type = 'executable';
        command = 'python';
        args = { '-m', 'debugpy.adapter' };
      }

      -- vim.fn.sign_define('DapBreakpoint', {text="🔴", texthl="", linehl="", numhl=""})
      -- vim.fn.sign_define('DapStopped', {text="🟢", texthl="", linehl="", numhl=""})
    ''}
    '';
  };

  my-dap-ui = {
    plugin = nvim-dap-ui;
    config = ''
      nnoremap <leader>du <cmd>lua require('dapui').toggle()<cr>

      augroup dap_ui
        au FileType dap-repl lua require('dap.ext.autocompl').attach()
        au BufEnter * :call SetDAPColors()
      augroup end

      function! SetDAPColors()
        hi default link DapUIVariable Normal
        hi default link DapUIScope Function
        hi default link DapUIDecoration Function
        hi default link DapUIType Type
        hi default link DapUISource Statement
        hi default link DapUILineNumber Constant
        hi default link DapUIFrameName Normal
        hi default link DapUIBreakpointsPath Function

        " Highlights below might change

        hi default link DapUIStoppedThread Function
        hi default link DapUIThread Function
        hi default link DapUIWatchesFrame Function
        hi default link DapUIWatchesHeader Function

        " hi default DapUIWatchesError guifg=#F70067
        hi default link DapUIWatchesError Error
        " hi default DapUIWatchesEmpty guifg=#F70067
        hi default link DapUIWatchesEmpty Error

        hi default DapUIFloatBorder guifg=#00F1F5
        hi default DapUIWatchesValue guifg=#A9FF68
        hi default DapUIBreakpointsInfo guifg=#A9FF68
        hi default DapUIBreakpointsCurrentLine guifg=#A9FF68 gui=bold

        hi default link DapUIBreakpointsLine DapUILineNumber
      endfunction

      ${mkLuaCode ''
      require('dapui').setup({
        icons = {
          expanded = "▾",
          collapsed = "▸"
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>" },
          open = "o",
          remove = "d",
          edit = "e",
        },
        sidebar = {
          open_on_start = true,
          elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "breakpoints",
            "stacks",
            "watches"
          },
          width = 40,
          position = "left" -- Can be "left" or "right"
        },
        tray = {
          open_on_start = true,
          elements = {
            "repl"
          },
          height = 10,
          position = "bottom" -- Can be "bottom" or "top"
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil   -- Floats will be treated as percentage of your screen.
        }
      })
    ''}
    '';
  };

  my-closetag = {
    plugin = vim-closetag;
    config = ''
      " https://github.com/alvan/vim-closetag#usage
       let g:closetag_filenames = '*.html,*.tsx,*.jsx'
    '';
  };

  my-presence = {
    plugin = presence-nvim;
    config = mkLuaCode ''
      require("presence"):setup({
        -- General options
        auto_update         = true,
        neovim_image_text   = "The One True Text Editor",
        main_image          = "file",                   -- Main image display (either "neovim" or "file")
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        enable_line_number  = false,                      -- Displays the current line number instead of the current project

        -- Rich Presence text options
        editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
        workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
      })
    '';
  };

  my-autopairs = {
    plugin = nvim-autopairs;
    config = mkLuaCode ''
      require('nvim-autopairs').setup()
      require("nvim-autopairs.completion.compe").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true -- it will auto insert `(` after select function or method item
      })
    '';
  };

  nvim-spell-pt = builtins.fetchurl {
    url =
      "https://github.com/mateusbraga/vim-spell-pt-br/raw/master/spell/pt.utf-8.spl";
    sha256 = "01zqss1fsc2rhaqhi10364qxyc64n2ndkn9d6rql20j3jvzbrlmd";
  };
in
{
  imports = [
    ./lsp/elixir.nix
    ./lsp/haskell.nix
    ./lsp/node.nix
    ./lsp/rnix.nix
    ./lsp/rust.nix
    ./lsp/lua.nix
    ./lsp/python.nix
    ./lsp/latex.nix
    ./lsp/godot.nix
  ];

  home.file = {
    "${config.xdg.configHome}/nvim/spell/pt.utf-8.spl".source = nvim-spell-pt;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Language specific
      vim-nix # Used mainly for filetype detection
      # Current elixir tree-sitter parser is very laggy when opening files
      vim-elixir

      # React / ts
      my-vim-prettier
      my-styled-components

      # Utils
      my-vim-tmux-navigator
      my-projectionist
      vim-commentary
      my-listtoggle
      vim-sensible
      vim-surround
      my-closetag
      targets-vim
      my-quickrun
      my-vim-test
      vim-repeat
      vim-lion # Alignment
      vim-swap

      my-multiple-cursors
      my-fzf-checkout
      my-fzf

      # Debugging
      my-nvim-dap
      my-dap-ui

      # Snippets
      vim-snippets
      my-ultisnips

      # Neovim lua things
      plenary-nvim
      my-autopairs
      my-treesitter
      nvim-treesitter-textobjects
      my-nvim-tree
      # my-telescope
      my-lspconfig
      my-compe
      my-trouble
      my-todo-comments

      # Git
      my-gitsigns
      my-fugitive
      my-blamer

      # Aesthetic
      # my-presence
      my-symbols-outline
      my-tokyonight-nvim
      nvim-web-devicons
      my-lualine
      my-indentline
    ];

    extraConfig = ''
      map <space> \

      set undofile
      set undolevels=1000
      set number relativenumber
      set expandtab tabstop=2 shiftwidth=2
      set cursorline
      set termguicolors
      set colorcolumn=80 " Ruler
      set nofoldenable
      set showcmd
      set ignorecase smartcase
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
      set completeopt=menuone,noselect
      set pumheight=10 " Max number of items in autocompletion popup
      set updatetime=400
      " Some plugin is removing `-` from the separators, for now lets just get it back.
      set iskeyword+=^-

      noremap Y "+y
      noremap H ^
      noremap L $
      nnoremap Q @@
      nnoremap <C-q> <C-w>q
      nnoremap <C-s> <cmd>update<cr>

      " Quickfix lists
      nnoremap [q <cmd>cprev<cr>
      nnoremap ]q <cmd>cnext<cr>
      nnoremap [Q <cmd>cfirst<cr>
      nnoremap ]Q <cmd>clast<cr>

      " Location lists
      nnoremap [w <cmd>lprev<cr>
      nnoremap ]w <cmd>lnext<cr>
      nnoremap [W <cmd>lfirst<cr>
      nnoremap ]W <cmd>llast<cr>

      " Marks
      nnoremap <C-g> `
      nnoremap <C-g><C-g>  `"

      " Tabs
      nnoremap <leader>to :tabnew<space>
      nnoremap <leader>tq :tabclose<cr>
      nnoremap <silent><leader>t< :execute "tabmove" tabpagenr() - 2 <CR>
      nnoremap <silent><leader>t> :execute "tabmove" tabpagenr() + 1 <CR>

      nnoremap <leader>ot <cmd>vsplit <bar> terminal<cr>

      nnoremap <silent> <leader>vQ <cmd>quitall!<cr>
      nnoremap <silent> <leader>vq <cmd>quitall<cr>
      nnoremap <silent> <leader>vr <cmd>source ~/.config/nvim/init.vim<cr>

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
    nv = "nvim";
  };
}
