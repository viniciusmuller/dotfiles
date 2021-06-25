{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    settings = { };

    plugins = with pkgs.vimPlugins; [
      fzf-vim
      # fzf-checkout
      # fzf-session

      vim-projectionist
      vim-commentary
      vim-sensible
      vim-surround
      vim-repeat

      vim-tmux-navigator
      auto-pairs
      vim-quickrun
      # vim-mkdir
      targets-vim
      vim-test

      vim-bbye

      # Git
      vim-gitgutter
      vim-fugitive

      vim-devicons
      vim-airline
      gruvbox-community
    ];

    extraConfig = ''
      set bg=dark
      colorscheme gruvbox

      set cursorline
      set termguicolors
    '';
  };
}
