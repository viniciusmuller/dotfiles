{ pkgs, prelude, ... }:

let
  lualine = {
    # TODO: Use upstream lualine once the pr of this repo gets merged
    plugin = pkgs.vimPlugins.lualine-nvim;
    config = prelude.mkLuaCode ''
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = {'', ''},
          section_separators = {'', ''},
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            {'diagnostics', sources = {'nvim_diagnostic'}}
          },
          lualine_c = {
            {
              'filename',
              path = 1
            }
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {'nvim-tree'}
      }
    '';
  };
in
{
  programs.neovim.plugins = [ lualine ];
}
