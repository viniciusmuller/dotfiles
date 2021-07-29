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

  telescope = {
    plugin = pkgs.vimPlugins.telescope-nvim;
    config = ''
      nnoremap <C-e>       <cmd>Telescope git_files<cr>
      nnoremap <leader>ff  <cmd>Telescope find_files<cr>
      nnoremap <leader>fs  <cmd>Telescope live_grep<cr>
      nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
      nnoremap <leader>fb  <cmd>Telescope buffers<cr>
      nnoremap <leader>fm  <cmd>Telescope man_pages<cr>
    '';
  };
in
{
  programs.neovim.plugins = [ telescope ];
}
