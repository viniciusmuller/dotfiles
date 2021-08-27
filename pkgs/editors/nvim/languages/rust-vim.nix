{ pkgs, ... }:

{
  # programs.neovim.plugins = [ pkgs.vimPlugins.rust-vim ];
  xdg.configFile."nvim/after/ftplugin/rust.vim".text = ''
    nnoremap <leader>pr :!cargo run src/main.rs<cr>
    nnoremap <leader>pb :!cargo build<cr>
  '';
}
