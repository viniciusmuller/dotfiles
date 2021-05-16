require('plugins')
require('settings')
require('mappings')
require('lsp')

require('lualine').setup{
	options = {
		theme = 'nightfly',
		component_separators = {},
		section_separators = {},
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'filename'},
		lualine_c = {''},
		lualine_x = {'filetype', 'fileformat', 'encoding'},
		lualine_y = {'branch'},
		lualine_z = {'location'}
	},
}

require('gitsigns').setup()

require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			["foo.bar"] = "Identifier",
		},
	},
	indent = {
		enable = true
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",

				-- Or you can define your own textobjects like this
				["iF"] = {
					python = "(function_definition) @function",
					cpp = "(function_definition) @function",
					c = "(function_definition) @function",
					java = "(method_declaration) @function",
				},
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	}
}
