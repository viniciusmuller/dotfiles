{ pkgs, prelude, ... }:

let
  telescope = {
    plugin = pkgs.vimPlugins.telescope-nvim;
    config = ''
        ${prelude.mkLuaCode ''
        local actions = require('telescope.actions')
        require('telescope').setup({
          defaults = {
            prompt_prefix = " λ ",
            mappings = {
              i = {
                ["<esc>"] = actions.close,
                ["<c-k>"] = "move_selection_previous",
                ["<c-j>"] = "move_selection_next",
                ["<c-p>"] = "preview_scrolling_up",
                ["<c-n>"] = "preview_scrolling_down",
              },
            },
            extensions = {
              fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
              }
            }
          },
        })

        require('telescope').load_extension('fzf')
      ''}

        nnoremap <leader>,   <cmd>Telescope buffers<cr>
        nnoremap <leader>.   <cmd>Telescope git_files theme=ivy<cr>
        nnoremap <leader>;   <cmd>Telescope live_grep theme=ivy<cr>
        nnoremap <leader>ff  <cmd>Telescope find_files<cr>
        nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
        nnoremap <leader>fm  <cmd>Telescope man_pages<cr>
        nnoremap <leader>fs  <cmd>Telescope lsp_workspace_symbols<cr>
        nnoremap <leader>fa  <cmd>Telescope lsp_code_actions theme=cursor<cr>

        nnoremap <leader>fc  <cmd>Telescope git_commits<cr>
        nnoremap <leader>gb  <cmd>Telescope git_branches<cr>
    '';
  };
  telescope-extensions = with pkgs.vimPlugins; [
    telescope-fzf-native-nvim
  ];
in
{
  programs.neovim.plugins = [ telescope ] ++ telescope-extensions;
  home.packages = with pkgs; [ fd ripgrep ];
}
