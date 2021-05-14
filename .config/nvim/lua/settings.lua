local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
-- Indentation
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for

-- Windows
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers  
opt('o', 'scrolloff', 5)                              -- Lines of context
opt('w', 'cursorline', true)                          -- Highlight the current cursor line
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current

-- Buffers
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)

-- Completion
opt('o', 'wildmode', 'longest:list,full')             -- Command-line completion mode
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals

-- Visual
opt('o', 'termguicolors', true)                       -- True color support

