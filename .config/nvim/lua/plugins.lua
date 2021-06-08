local execute = vim.api.nvim_command
local fn = vim.fn

local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	if vim.fn.input("Hent packer.nvim? (y for yada)") ~= "y" then
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
	print("Henter packer.nvim...")

	return
end

return require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Lsp
  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup({
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'always';
        throttle_time = 80;
        source_timeout = 200;
        incomplete_delay = 400;
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
        };
      })
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
    'hoob3rt/lualine.nvim',
    config = function ()
      require('lualine').setup{

        sections = {
          lualine_c = {
            {
              -- TODO: Statusline is being overwritten when writing to a file
              'diagnostics',
              sources = {'nvim_lsp'},
            },
            lualine_d = {
              {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
              }
            }
          }
        },

        -- sections = {
        --   lualine_a = {
        --     'diagnostics',
        --     sources = {'nvim_lsp'},
        --     sections = {'error', 'warn', 'info', 'hint'},
        --     -- color_error = colors.red,
        --     -- color_warn = colors.yellow,
        --     -- color_info = colors.cyan
        --   }
        -- },
        options = {
          theme = 'tokyonight'
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
  use {
    'kyazdani42/nvim-web-devicons',
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

  -- TODO: Make snippets work
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use {
    -- TODO: Find hidden files
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'Shatur95/neovim-session-manager',
    config = function ()
      vim.g.autoload_last_session = false
      require('telescope').load_extension('session_manager')
    end
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup{} end
  }
  use 'tpope/vim-fugitive'
end)
