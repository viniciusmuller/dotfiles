local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function nmap(mapping, command, opts)
  map('n', mapping, command, opts)
end

function tmap(mapping, command, opts)
  map('t', mapping, command, opts)
end


-- Set the leader key
vim.g.mapleader = " "

-- Telescope
nmap('<Leader>fg',  '<cmd>Telescope git_files<cr>', {})
nmap('<Leader>ff',  '<cmd>Telescope find_files<cr>', {})
nmap('<Leader>fh',  '<cmd>Telescope help_tags<cr>', {})
nmap('<Leader>fs',  '<cmd>Telescope live_grep<cr>', {})
nmap('<Leader>fb',  '<cmd>Telescope buffers<cr>', {})

map('', '<Leader>qr', ':QuickRun<cr>', {})

-- Project
nmap('<Leader>pt',  ':TodoTrouble<cr>', {})
nmap('<Leader>pa',  ':AV<cr>', {})

-- Lsp

-- Others
-- TODO: Make this works without nnoremap
nmap('H', '^', {})
nmap('zs', ':update<cr>', { silent = true })

-- Neovim terminal
tmap('<Esc>', '<C-\\><C-n>', {})

