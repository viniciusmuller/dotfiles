local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local function nmap(mapping, command, opts)
  map('n', mapping, command, opts)
end

local function tmap(mapping, command, opts)
  map('t', mapping, command, opts)
end

-- Lsp
local function lsp_mappings()

end

-- Set the leader key
vim.g.mapleader = " "

-- Telescope
nmap('<Leader>fg',  '<cmd>Telescope git_files<cr>', {})
nmap('<Leader>ff',  '<cmd>Telescope find_files<cr>', {})
nmap('<Leader>fh',  '<cmd>Telescope help_tags<cr>', {})
nmap('<Leader>fs',  '<cmd>Telescope live_grep<cr>', {})
nmap('<Leader>fb',  '<cmd>Telescope buffers<cr>', {})
nmap('<Leader>fm',  '<cmd>Telescope man_pages<cr>', {})

nmap('<Leader>qr', ':QuickRun<cr>', {})
nmap('<Leader>qf', ':Trouble quickfix<cr>', {})

-- Project
nmap('<Leader>pt',  ':TodoTrouble<cr>', {})
nmap('<Leader>pa',  ':AV<cr>', {})

-- Git
nmap('<Leader>G',  ':tab G<cr>', {})

-- Others
-- TODO: Make this works without nnoremap
nmap('H', '^', {})
nmap('zs', ':update<cr>', { silent = true })
nmap('<c-w>z', ':ZenMode<cr>', { silent = true })
nmap('<c-w>t', ':term<cr>', { silent = true })
-- TODO: make this work
nmap('Y', '"*y', {})

nmap('<c-p>', '@:', {})

-- Neovim terminal
tmap('<Esc>', '<C-\\><C-n>', {})
