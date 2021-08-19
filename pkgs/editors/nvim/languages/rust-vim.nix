{ pkgs, ... }:

{
  programs.neovim.plugins = [ pkgs.vimPlugins.rust-vim ];
  xdg.configFile."nvim/after/ftplugin/rust.vim".text = ''
    nnoremap <leader>pr :RustRun<cr>

    " TODO: Maybe find a way to use clippy by default
    nnoremap <leader>pl :Neomake! clippy<cr>
    augroup rust
      autocmd BufWritePre *.rs :Neomake! clippy
    augroup end
  '';
}
