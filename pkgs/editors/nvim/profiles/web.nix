{pkgs, ...}:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    tagalong-vim
    emmet-vim
    vim-prettier
  ];
}
