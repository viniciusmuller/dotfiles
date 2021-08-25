{ pkgs, ... }:

{
  programs.neovim.plugins = [ pkgs.vimPlugins.rust-vim ];
  xdg.configFile."nvim/after/ftplugin/rust.vim".text = ''
    nnoremap <leader>pr :RustRun<cr>
  '';
}
