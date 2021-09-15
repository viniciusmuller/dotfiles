{ pkgs, prelude, ... }:

let
  bufferline = {
    plugin = pkgs.vimPlugins.bufferline-nvim;
    config = ''
      set termguicolors

      ${prelude.mkLuaCode ''
        require("bufferline").setup{
          options = {
            show_buffer_close_icons = false,
            show_close_icon = false,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = true,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              local icon = level:match("error") and " " or " "
              return " " .. icon .. count
            end,
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
              }
            }
          }
        }
      ''}

      nnoremap <leader>, <cmd>BufferLinePick<cr>
      nnoremap gt <cmd>BufferLineCycleNext<cr>
      nnoremap gT <cmd>BufferLineCyclePrev<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ bufferline ];
}
