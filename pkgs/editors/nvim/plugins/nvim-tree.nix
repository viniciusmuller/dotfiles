{ pkgs, prelude, ... }:

let
  nvim-tree = {
    plugin = pkgs.vimPlugins.nvim-tree-lua;
    config = ''
      ${prelude.mkLuaCode ''
        require('nvim-tree').setup {
          renderer = {
            icons = {
              show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
              }
            },
            indent_markers = {
              enable = true,
              inline_arrows = true,
              icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
              },
            },
          },
          hijack_directories  = {
            enable = true,
            auto_open = true,
          },
          open_on_tab         = false,
          hijack_cursor       = false,
          update_cwd          = false,
          update_focused_file = {
            enable      = true,
            update_cwd  = false,
            ignore_list = {}
          },
          system_open = {
            cmd  = nil,
            args = {}
          },
          view = {
            adaptive_size = true,
            width = 30,
            side = 'left',
            mappings = {
              custom_only = false,
              list = {}
            }
          }
        }
      ''}

      nnoremap tn <cmd>NvimTreeToggle<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ nvim-tree ];
}
