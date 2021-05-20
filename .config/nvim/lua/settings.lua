local api = vim.api
local set = api.nvim_set_option

local indent = 2

-- TODO: Add undo and figure out proper way to set things
-- Indentation
set('expandtab', true)                           -- Use spaces instead of tabs
set('shiftwidth', indent)                        -- Size of an indent
set('tabstop', indent)                           -- Number of spaces tabs count for
set('autoindent', true)                          -- TODO: description
set('smartindent', true)                         -- TODO: description

set('listchars', 'tab:| ,extends:›,precedes:‹,nbsp:∙,trail:∙')                           -- Use spaces instead of tabs
set('undofile', true)                            -- Save undos after file closes
-- TODO: Files paths not working
set('undodir', '/home/vini/.config/nvim/undo')            -- Where to save undo histories
set('undolevels', 1000)                          -- Save undos after file closes

-- TODO: Make backup work
set('backup', true)                              -- Save files backup
set('backupdir', '/home/vini/.config/nvim/backup')        -- Where to store the backup files
set('writebackup', true)                         -- Make backup before writing overwriting current buffer
set('showmode', false)                         -- TODO: description

-- Windows
set('number', true)                              -- Print line number
set('relativenumber', true)                      -- Relative line numbers
set('scrolloff', 5)                              -- Lines of context
set('cursorline', true)                          -- Highlight the current cursor line
set('splitbelow', true)                          -- Put new windows below current
set('splitright', true)                          -- Put new windows right of current
set('colorcolumn', '80')                         -- 80 characters ruler
set('breakindent', true)                         -- 80 characters ruler

-- Buffers
set('shiftround', true)                          -- Round indent
set('hidden', true)                              -- Enable modified buffers in background
set('list', true)                                -- Show some invisible characters (tabs...)
-- TODO: Figure out why this keeps being unset
set('swapfile', false)                           -- Disable buffer swap files
set('foldenable', false)                         -- Don't fold by default
set('foldnestmax', 2)                            -- Only fold up to this level

-- Completion
set('wildmode', 'longest:list,full')             -- Command-line completion mode
set('ignorecase', true)                          -- Ignore case
-- gopt('smartcase', false)                           -- Don't ignore case with capitals

-- Visual
set('termguicolors', true)                       -- True color support

-- Globals
api.nvim_set_var('test#strategy', 'neovim')

-- Others
-- TODO: Use nvim api for setting those
vim.o.guifont = "JetBrains Mono:h12"              -- Set gui font for neovide

vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.completeopt = vim.o.completeopt .. ",menuone,noinsert"

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
