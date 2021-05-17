local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section

local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  purple = '#b56dd1',
  blue = '#51afef',
  red = '#ec5f67';
}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue, colors.bg}
  },
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          V= 'VISUAL',
          [''] = 'BLOCK',
          v ='VISUAL',
          c  = 'COMMAND',
          ['r?'] = ':CONFIRM',
          rm = '--MORE',
          R  = 'REPLACE',
          Rv = 'VIRTUAL',
          s  = 'SELECT',
          S  = 'SELECT',
          ['r']  = 'HIT-ENTER',
          [''] = 'SELECT',
          t  = 'TERMINAL',
          ['!']  = 'SHELL',
      }
      local mode_color = {
          n = colors.green,
          i = colors.blue,v=colors.magenta,[''] = colors.blue,V=colors.blue,
          -- c = colors.red,
          no = colors.magenta,
          s = colors.orange,
          S=colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          cv = colors.red,
          ['!']  = colors.green,t = colors.green,
          c = colors.purple,
          ['r?'] = colors.red,
          ['r']  = colors.red,
          rm = colors.red,
          R  = colors.red,
          Rv = colors.magenta,
      }
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
      return alias[vim_mode] .. '   '
    end,
    highlight = {colors.red, colors.bg ,'bold'},
  },
}

gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg},
  },
}

gls.left[4] = {
  FileName = {
    provider = 'FileName',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    condition = condition.buffer_not_empty,
    highlight = {'NONE', colors.bg, 'bold'}
  }
}

gls.left[5] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
}
gls.left[6] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg},
  }
}

gls.left[7] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan, colors.bg},
  }
}

gls.left[8] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg},
  }
}

-- TODO: Fix spaces
gls.mid[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan, colors.bg,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
	provider = function()
		return vim.bo.fileformat
	end,
    condition = condition.hide_in_width,
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg, 'bold'}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function() return '   ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.violet, colors.bg, 'bold'},
  }
}

gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    highlight = {colors.violet, colors.bg, 'bold'},
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green, colors.bg},
  }
}

gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange, colors.bg},
  }
}

gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red, colors.bg},
  }
}

gls.right[8] = {
  RainbowBlue = {
    provider = function() return ' ' end,
    highlight = {colors.bg, colors.bg}
  },
}

gls.right[9] = {
  PerCent = {
    provider = 'LinePercent',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg, colors.bg, 'bold'},
  }
}

-- TODO: Remove spaces here
gls.right[10] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = {colors.fg, colors.bg, 'bold'},
  },
}

-- gls.short_line_left[1] = {
--   BufferType = {
--     provider = 'FileTypeName',
--     separator_highlight = {'NONE', colors.bg},
--     highlight = {colors.blue, colors.bg, 'bold'}
--   }
-- }

-- gls.short_line_left[2] = {
--   SFileName = {
--     provider =  'SFileName',
--     condition = condition.buffer_not_empty,
--     highlight = {colors.fg, colors.bg, 'bold'}
--   }
-- }

-- gls.short_line_right[1] = {
--   BufferIcon = {
--     provider= 'BufferIcon',
--     highlight = {colors.fg, colors.bg}
--   }
-- }
