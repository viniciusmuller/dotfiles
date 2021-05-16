-- Global option
local function gopt(key, value)
  vim.o[key] = value
end

-- Window option
local function wopt(key, value)
  vim.wo[key] = value
end

-- Buffer option
local function bopt(key, value)
  vim.bo[key] = value
end

local indent = 2

-- TODO: Add undo and figure out proper way to set things
-- Indentation
bopt('expandtab', true)                           -- Use spaces instead of tabs
bopt('shiftwidth', indent)                        -- Size of an indent
bopt('tabstop', indent)                           -- Number of spaces tabs count for
bopt('autoindent', true)                          -- TODO: description
bopt('smartindent', true)                         -- TODO: description

gopt('listchars', 'tab:| ,extends:›,precedes:‹,nbsp:∙,trail:∙')                           -- Use spaces instead of tabs
bopt('undofile', true)                            -- Save undos after file closes
-- TODO: Files paths not working
gopt('undodir', '~/.config/nvim/undo')            -- Where to save undo histories
gopt('undolevels', 1000)                          -- Save undos after file closes

-- TODO: Make backup work
gopt('backup', false)                              -- Save files backup
gopt('backupdir', '~/.config/nvim/backup')        -- Where to store the backup files
gopt('writebackup', false)                         -- Make backup before writing overwriting current buffer

-- Windows
wopt('number', true)                              -- Print line number
wopt('relativenumber', true)                      -- Relative line numbers
gopt('scrolloff', 5)                              -- Lines of context
wopt('cursorline', true)                          -- Highlight the current cursor line
gopt('splitbelow', true)                          -- Put new windows below current
gopt('splitright', true)                          -- Put new windows right of current
wopt('colorcolumn', '80')                         -- 80 characters ruler

-- Buffers
gopt('shiftround', true)                          -- Round indent
gopt('hidden', true)                              -- Enable modified buffers in background
wopt('list', true)                                -- Show some invisible characters (tabs...)
-- TODO: Figure out why this keeps being unset
bopt('swapfile', false)                           -- Disable buffer swap files
wopt('foldenable', false)                         -- Don't fold by default
wopt('foldnestmax', 2)                            -- Only fold up to this level

-- Completion
gopt('wildmode', 'longest:list,full')             -- Command-line completion mode
gopt('ignorecase', true)                          -- Ignore case
-- gopt('smartcase', false)                           -- Don't ignore case with capitals

-- Visual
gopt('termguicolors', true)                       -- True color support

-- Others
vim.o.guifont = "JetBrains Mono:h12"              -- Set gui font for neovide

vim.g.startify_session_persistence = 1
vim.g["test#strategy"] = 'neovim'

vim.o.shortmess = vim.o.shortmess .. 'c'
-- TODO: figure out why this doesn't work
-- vim.o.completeopt = vim.o.completeopt .. "menuone,noinsert"
vim.o.completeopt = "menuone,noinsert"

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
