{ pkgs, prelude, ... }:

let
  lualine = {
    # TODO: Use upstream lualine once the pr of this repo gets merged
    plugin = pkgs.vimUtils.buildVimPlugin {
      pname = "lualine-nvim";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "shadmansaleh";
        repo = "lualine.nvim";
        rev = "62bfe80fb6e0cd51cec6fc9df9e1768f7d37d299";
        sha256 = "sha256-/634qP+VF+YkLOddJ0rd1L7+x9+/mxqMwDXlHrVvyGg=";
      };

      prePatch = "rm Makefile";

      meta.homepage = "https://github.com/shadmansaleh/lualine.nvim";
    };

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
