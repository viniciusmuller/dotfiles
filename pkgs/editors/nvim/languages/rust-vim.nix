{ pkgs, ... }:

{
  # programs.neovim.plugins = [ pkgs.vimPlugins.rust-vim ];
  xdg.configFile."nvim/after/ftplugin/rust.vim".text = ''
    nnoremap <leader>pr !cargo run<cr>
    nnoremap <leader>pb !cargo build<cr>
  '';
}
