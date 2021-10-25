{ pkgs, prelude, ... }:

let
  nvim-tree = {
    plugin = pkgs.vimPlugins.nvim-tree-lua;
    config = ''
      ${prelude.mkLuaCode ''
        require('nvim-tree').setup {
          disable_netrw       = true,
          hijack_netrw        = true,
          open_on_setup       = false,
          ignore_ft_on_setup  = {},
          update_to_buf_dir   = {
            enable = true,
            auto_open = true,
          },
          auto_close          = false,
          open_on_tab         = false,
          hijack_cursor       = false,
          update_cwd          = false,
          diagnostics         = {
            enable = false,
            icons = {
              hint = "",
              info = "",
              warning = "",
              error = "",
            }
          },
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
            width = 30,
            height = 30,
            side = 'left',
            auto_resize = false,
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
