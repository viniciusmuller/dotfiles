--let  check if packer is installed (~/local/share/nvim/site/pack)
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
       require("todo-comments").setup{}
    end
  }

  use {
    'glepnir/galaxyline.nvim',
    config = function() require('statusline') end
  }

  use {
    'mhinz/vim-startify',
    config = function ()
      vim.g.startify_session_persistence = 1
      vim.g.startify_session_dir = '~/.config/nvim/session'
      vim.g.startify_lists = {
        {
          type = 'sessions',
          header = {'   Sessions'}
        },
        {
          type = 'files',
          header = {'   Files'}
        }, 
        {
          type = 'dir',
          header = {'   Files ' .. vim.fn.getcwd()}
        }, 
        {
          type = 'bookmarks',
          header = {'   Bookmarks'}
        }, 
        {
          type = 'commands',
          header = {'   Commands'}
        }
      }
    end
  }
  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup{}
    end
  }
  use 'simrat39/symbols-outline.nvim'
  use {'kyazdani42/nvim-web-devicons',
    config = function()
      -- Add nvim-web-devicons to startify
      function _G.webDevIcons(path)
        local filename = vim.fn.fnamemodify(path, ':t')
        local extension = vim.fn.fnamemodify(path, ':e')
        return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
      end
    end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup{
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = true, -- disables git signs
          tmux = true, -- disables the tmux statusline
          -- this will change the font size on kitty when in Zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          -- TODO: Make kitty works with this
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
        },
      }
    end
  }
  use {
    'folke/tokyonight.nvim',
    config = 'vim.cmd[[colorscheme tokyonight]]'
  }

  -- Utils
  use {'easymotion/vim-easymotion',
    config = function()
      vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-overwin-f2)', {})
      vim.g.EasyMotion_smartcase = 1
    end
  }
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-projectionist'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'thinca/vim-quickrun'
  use 'wellle/targets.vim'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'tpope/vim-repeat'

  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use {
    -- TODO: Find hidden files
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }
  use 'tpope/vim-fugitive'
end)
