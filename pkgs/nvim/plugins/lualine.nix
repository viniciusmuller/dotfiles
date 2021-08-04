{ pkgs, ... }:

let
  mkLuaCode =
    (
      code:
      ''
        lua << EOF
          ${code}
        EOF
      ''
    );

  # Lualine is currently broken (status bar shows blank even without any other
  # plugins active)
  lualine = {
    plugin = pkgs.vimPlugins.lualine-nvim;
    config = mkLuaCode ''
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
            {'diagnostics', sources = {'nvim_lsp'}}
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
