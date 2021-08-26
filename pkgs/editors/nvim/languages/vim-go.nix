{ pkgs, ... }:

{
  # programs.neovim.plugins = [ pkgs.vimPlugins.vim-go ];
  xdg.configFile."nvim/after/ftplugin/go.vim".text = ''

  '';
}
