vim.cmd[[
let mapleader = " "
let maplocalleader = ","

set undofile
set noshowmode
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
set guifont=JetBrains\ Mono:h9
set wildignorecase
set linebreak
set autoindent
set smartindent
set splitright
set scrolloff=5
set lazyredraw
set noswapfile
set nomodeline
set autoread
set completeopt=menuone,noselect
set pumheight=10 " Max number of items in autocompletion popup
set pumwidth=25
set updatetime=400
" Some plugin is removing `-` from the separators, for now lets just get it back.
set iskeyword-=-
" Don't auto line break when inserting text
set formatoptions-=t
set shortmess+=cI
" set listchars=tab:»\ ,space:·,eol:¬
" set list

noremap Y "+y
noremap H ^
noremap L $
nnoremap <C-p> <C-^>

nnoremap j gj
nnoremap k gk

nnoremap <C-q> <C-w>q
" nnoremap <C-s> <cmd>update<cr>

" -- Quickfix/Location lists --
command Cnext try | cnext | catch | cfirst | catch | endtry
command Cprev try | cprev | catch | clast  | catch | endtry
command Lnext try | lnext | catch | lfirst | catch | endtry
command Lprev try | lprev | catch | llast  | catch | endtry

nnoremap [q <cmd>Cprev<cr>
nnoremap ]q <cmd>Cnext<cr>
nnoremap [Q <cmd>cfirst<cr>
nnoremap ]Q <cmd>clast<cr>

nnoremap [w <cmd>Lprev<cr>
nnoremap ]w <cmd>Lnext<cr>
nnoremap [W <cmd>lfirst<cr>
nnoremap ]W <cmd>llast<cr>

" Tabs
nnoremap <leader>to :tabnew<space>
nnoremap <leader>tq :tabclose<cr>
nnoremap <silent>g< :tabmove tabpagenr() - 2<cr>
nnoremap <silent>g> :tabmove tabpagenr() + 1<cr>

" Buffers
nnoremap <leader>bd <cmd>bd<cr>

nnoremap <silent> <leader>vQ <cmd>quitall!<cr>
nnoremap <silent> <leader>vq <cmd>quitall<cr>
nnoremap <silent> <leader>vr <cmd>source $MYVIMRC<cr>

" Allow the . to execute once for each line of a visual selection
vnoremap . :normal .<cr>

augroup my_autocommands
  " Remove trailing whitespaces on write
  au BufWritePre * %s/\s\+$//e
  " Open help windows vertically splitted
  au FileType help wincmd L
  " Highlight on yank (nvim only)
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedYankRegion", timeout=50}

  " Handle nix files
  au BufEnter *.nix set ft=nix
  autocmd FileType nix,elixir setlocal commentstring=#\ %s
  autocmd FileType heex setlocal commentstring=<%#\ %s \%>
augroup end

augroup numbertoggle
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end


" Telescope (TODO: Turn into lua)
nnoremap <leader>,   <cmd>Telescope buffers<cr>
nnoremap <leader>.   <cmd>Telescope git_files theme=ivy<cr>
nnoremap <leader>;   <cmd>Telescope live_grep theme=ivy<cr>
nnoremap <leader>ff  <cmd>Telescope find_files<cr>
nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
nnoremap <leader>fm  <cmd>Telescope man_pages<cr>
nnoremap <leader>fs  <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fa  <cmd>Telescope lsp_code_actions theme=cursor<cr>

nnoremap <leader>fc  <cmd>Telescope git_commits<cr>
nnoremap <leader>gb  <cmd>Telescope git_branches<cr>

" Nvim-tree
nnoremap tn <cmd>NvimTreeToggle<cr>
]]

function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
end

-- Packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
    use {
        'neovim/nvim-lspconfig',
        config = function ()
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
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
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

            -- vim.cmd[[
            --     augroup lsp
            --     autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})
            --     augroup end
            -- ]]

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
                buf_set_keymap('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
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
        end
    }
    use {
        'ray-x/lsp_signature.nvim',
        config = function() 
            require ('lsp_signature').setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded"
                }
            })
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            require('nvim-tree').setup {
                disable_netrw       = true,
                hijack_netrw        = true,
                open_on_setup       = false,
                ignore_ft_on_setup  = {},
                hijack_directories  = {
                    enable = true,
                    auto_open = true,
                },
                open_on_tab         = false,
                hijack_cursor       = false,
                update_cwd          = false,
                diagnostics         = {
                    enable = false,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    }
                },
                update_focused_file = {
                    enable      = true,
                    update_cwd  = false,
                    ignore_list = {}
                },
                system_open = {
                    cmd  = nil,
                    args = {}
                },
                view = {
                    width = 30,
                    height = 30,
                    side = 'left',
                    mappings = {
                        custom_only = false,
                        list = {}
                    }
                }
            }
        end
    }
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_vscode').load()
        end,
        requires = { 'rafamadriz/friendly-snippets' }
    }
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')
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
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    }
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end,
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path'
        }
    }
    use {
        'steelsojka/pears.nvim', -- TODO: Maybe change autopair plugin
        config = function ()
           require('pears').setup()
        end
    }
    -- TODO: Make this work cleanly on Windows
    -- use {
    --     'nvim-telescope/telescope-fzf-native.nvim',
    --     -- On windows, requires https://www.microsoft.com/en-us/download/details.aspx?id=48159 and CMake
    --     run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    -- }
    use {
        'nvim-telescope/telescope.nvim',
        config = function ()
            local actions = require('telescope.actions')

            require('telescope').setup({
                defaults = {
                    prompt_prefix = " λ ",
                    mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<c-k>"] = "move_selection_previous",
                        ["<c-j>"] = "move_selection_next",
                        ["<c-p>"] = "preview_scrolling_up",
                        ["<c-n>"] = "preview_scrolling_down",
                    },
                    },
                    extensions = {
                        fzf = {
                            fuzzy = true,                    -- false will only do exact matching
                            override_generic_sorter = false, -- override the generic sorter
                            override_file_sorter = true,     -- override the file sorter
                            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        }
                    }
                },
            })

            -- require('telescope').load_extension('fzf')
        end,
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function ()
            map('n', '<leader>gm', ':Gitsigns stage_hunk<CR>')

            require('gitsigns').setup{
                    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 100,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>',
            }

            local gs = package.loaded.gitsigns

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            -- Actions
            map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function() gs.blame_line{full=true} end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
    use {
        'folke/tokyonight.nvim',
        config = function ()
            vim.cmd[[colorscheme tokyonight]]
        end
    }
    use { -- Depends on ripgrep and fd for some commands
        'folke/todo-comments.nvim',
        config = function ()
            map('n', '<leader>pt', '<cmd>TodoQuickFix<cr>')
            require('todo-comments').setup()
        end
    }
    use 'sheerun/vim-polyglot'
    use 'wellle/targets.vim'
    use 'christoomey/vim-tmux-navigator'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sensible'
    use 'tpope/vim-surround'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
