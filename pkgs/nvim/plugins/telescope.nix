{ pkgs, ... }:

let
  telescope = {
    plugin = pkgs.vimPlugins.telescope-nvim;
    config = ''
      nnoremap <leader>,   <cmd>Telescope buffers<cr>
      nnoremap <leader>.   <cmd>Telescope git_files<cr>
      nnoremap <leader>;   <cmd>Telescope live_grep<cr>
      nnoremap <leader>ff  <cmd>Telescope find_files<cr>
      nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
      nnoremap <leader>fm  <cmd>Telescope man_pages<cr>

      nnoremap <leader>fc  <cmd>Telescope git_commits<cr>
      nnoremap <leader>gb  <cmd>Telescope git_branches<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ telescope ];
  home.packages = with pkgs; [ fd ripgrep ];
}
