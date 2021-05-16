-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  PromptPackerInstall()
end

function PromptPackerInstall()
  if vim.fn.input("Install packer.nvim? (y/n)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local git_clone_cmd = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(git_clone_cmd)
  print("packer.nvim installed!")

  return
end

return require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Lsp
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-lua/completion-nvim',
    config = function ()
      vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}
      vim.g.completion_matching_ignore_case = 1
      vim.g.completion_trigger_character = {".", "::"}
      vim.g.completion_timer_cycle = 50
    end
  }
  use 'kabouzeid/nvim-lspinstall'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Aesthetics
  use {
    "folke/todo-comments.nvim",
    config = function()
	require('todo-comments').setup{}
    end
  }
  use 'hoob3rt/lualine.nvim'
  use 'mhinz/vim-startify'
  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup{}
    end
  }
  use 'simrat39/symbols-outline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'folke/tokyonight.nvim',
    config = 'vim.cmd[[colorscheme tokyonight]]'
  }

  -- Utils
  use 'easymotion/vim-easymotion'
  use 'tpope/vim-projectionist'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'thinca/vim-quickrun'
  use 'wellle/targets.vim'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'tpope/vim-repeat'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Language specific
  use 'elixir-editors/vim-elixir'
end)
