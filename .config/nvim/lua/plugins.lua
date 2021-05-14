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

	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-repeat'
	use 'tpope/vim-sensible'

	-- Git
	-- TODO: use gitsigns.nvim
  use 'airblade/vim-gitgutter'
  -- use {
  -- 'lewis6991/gitsigns.nvim',
  -- requires = { 'nvim-lua/plenary.nvim' },
  -- config = function()
  --   require('gitsigns').setup()
  -- end
-- }
	use 'tpope/vim-fugitive'

	use 'SirVer/ultisnips'

	use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

	use 'kyazdani42/nvim-web-devicons'
	-- Multi cursor
	-- use {'mg979/vim-visual-multi', branch = 'master'}

	-- Clap
	-- use 'liuchengxu/vim-clap'

	-- Close tags
	-- use 'alvan/vim-closetag'

	-- Auto pairs
	-- !! -> breaks visual-multi (multi-cursor)
	use 'jiangmiao/auto-pairs'

	-- Indentline
	use 'vim-scripts/indentLine.vim'

	-- Neoformat
	-- use 'sbdchd/neoformat'

	-- Easymotion
	-- use 'easymotion/vim-easymotion'

	-- Galaxyline
	-- use {
	-- 	'glepnir/galaxyline.nvim',
	-- 	-- some optional icons baby
	-- 	requires = {'kyazdani42/nvim-web-devicons', opt = true}
	-- }

	-- Colorizer
	-- use 'norcalli/nvim-colorizer.lua'

	-- Color schemes
  -- use {
  --   'sainnhe/gruvbox-material',
  --   config = 'vim.cmd[[let g:gruvbox_material_background = \'hard\']]'
  -- }
  use {
    'folke/tokyonight.nvim',
    config = 'vim.cmd[[colorscheme tokyonight]]'
  }
end)
