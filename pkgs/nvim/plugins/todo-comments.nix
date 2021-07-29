{ pkgs, ... }:

let
  todo-comments = {
    plugin = pkgs.vimPlugins.todo-comments-nvim;
    config = ''
      nnoremap <leader>pt <cmd>TodoQuickFix<cr>
      lua require('todo-comments').setup{}
    '';
  };

in
{
  programs.neovim.plugins = [ todo-comments ];
}
