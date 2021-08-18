{ pkgs, ... }:

{
  programs.neovim.plugins = [ pkgs.vimPlugins.vim-go ];
  xdg.configFile."nvim/after/ftplugin/go.vim".text = ''
    command GOLINT :cexpr system('golangci-lint run --print-issued-lines=false')

    nnoremap <leader>pa :GoAlternate<cr>
    nnoremap <leader>pl :GOLINT<cr>
  '';
}
