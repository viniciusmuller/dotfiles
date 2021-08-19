{ pkgs, ... }:

{
  programs.vim = {
    enable = true;

    settings = {
      number = true;
      relativenumber = true;
      hidden = true;
      expandtab = true;
      smartcase = true;
    };

    plugins = with pkgs.vimPlugins; [
      fzf-vim

      vim-commentary
      vim-sensible
      vim-surround
      vim-repeat

      vim-tmux-navigator
      auto-pairs
      targets-vim

      gruvbox-community
    ];

    extraConfig = ''
      set bg=dark
      colorscheme gruvbox

      set cursorline
      set termguicolors

      nnoremap <space>ff :Files<cr>
    '';
  };
}
