{ config, pkgs, ... }:

with pkgs.vimPlugins;
let
  my-noplugin-statusline = ''
    set statusline=
    set statusline+=\ %f " Relative path to file in current buffer
    set statusline+=\ %m%r%w " Readonly, modified and preview tags
    set statusline+=%= " Left and right separator
    set statusline+=%y\ " Filetype
    set statusline+=%l:%c\ %p%%\ " Line and column
  '';

  nvim-spell-pt = builtins.fetchurl {
    url =
      "https://github.com/mateusbraga/vim-spell-pt-br/raw/3d7eb3098de77b86c8a880354b442b3d84b18a72/spell/pt.utf-8.spl";
    sha256 = "01zqss1fsc2rhaqhi10364qxyc64n2ndkn9d6rql20j3jvzbrlmd";
  };

  aliases = {
    v = "nvim";
    nv = "nvim";
  };

  initVimBefore = ''
    let mapleader = " "
    let maplocalleader = ","
  '';

  initVimAfter = ''
    set undofile
    set undolevels=1000
    set number relativenumber
    set expandtab tabstop=2 shiftwidth=2
    set cursorline
    set termguicolors
    set colorcolumn=80 " Ruler
    set nofoldenable
    set showcmd
    set ignorecase smartcase
    set textwidth=80
    set sessionoptions+=globals
    set hidden
    set guifont=JetBrains\ Mono:h12
    set wildignorecase
    set linebreak
    set autoindent
    set smartindent
    set splitright
    set scrolloff=5
    set lazyredraw
    set noswapfile
    set autoread
    set completeopt=menuone,noselect
    set pumheight=10 " Max number of items in autocompletion popup
    set pumwidth=25
    set updatetime=400
    " Some plugin is removing `-` from the separators, for now lets just get it back.
    set iskeyword+=^-
    " Don't auto line break when inserting text
    set formatoptions-=t

    noremap Y "+y
    noremap H ^
    noremap L $
    nnoremap Q @@
    nnoremap <C-q> <C-w>q
    nnoremap <C-s> <cmd>update<cr>

    " Quickfix lists
    nnoremap [q <cmd>cprev<cr>
    nnoremap ]q <cmd>cnext<cr>
    nnoremap [Q <cmd>cfirst<cr>
    nnoremap ]Q <cmd>clast<cr>

    " Location lists
    nnoremap [w <cmd>lprev<cr>
    nnoremap ]w <cmd>lnext<cr>
    nnoremap [W <cmd>lfirst<cr>
    nnoremap ]W <cmd>llast<cr>

    " Tabs
    nnoremap <leader>to :tabnew<space>
    nnoremap <leader>tq :tabclose<cr>
    nnoremap <silent><leader>t< :execute "tabmove" tabpagenr() - 2 <CR>
    nnoremap <silent><leader>t> :execute "tabmove" tabpagenr() + 1 <CR>

    " nnoremap <leader>ot <cmd>vsplit <bar> terminal<cr>

    nnoremap <silent> <leader>vQ <cmd>quitall!<cr>
    nnoremap <silent> <leader>vq <cmd>quitall<cr>
    nnoremap <silent> <leader>vr <cmd>source $MYVIMRC<cr>

    augroup my_autocommands
      " Remove trailing whitespaces on write
      au BufWritePre * %s/\s\+$//e
      " Open help windows vertically splitted
      au FileType help wincmd L
    augroup end
  '';
in
{
  imports = [
    # Language specific language server support
    ./lsp/ccls.nix
    ./lsp/clojure.nix
    ./lsp/elixir.nix
    ./lsp/godot.nix
    ./lsp/haskell.nix
    ./lsp/latex.nix
    ./lsp/lua.nix
    ./lsp/node.nix
    ./lsp/python.nix
    ./lsp/rnix.nix
    ./lsp/rust.nix

    # Language specific plugins
    ./plugins/lfe.nix

    # ---- Plugins ----

    # Language server protocol
    ./plugins/lspconfig.nix

    # Utils
    ./plugins/tree-sitter.nix
    ./plugins/nvim-tree.nix
    ./plugins/compe.nix
    ./plugins/neorg.nix
    ./plugins/trouble.nix
    ./plugins/autopairs.nix
    ./plugins/ultisnips.nix
    ./plugins/telescope.nix
    ./plugins/projectionist.nix
    ./plugins/indentline.nix
    ./plugins/vim-test.nix
    ./plugins/vim-quickrun.nix
    ./plugins/togglelist.nix
    ./plugins/closetag.nix
    ./plugins/visual-multi.nix

    ./plugins/conjure.nix

    # Debugging
    ./plugins/dap.nix
    ./plugins/dap-ui.nix

    # Git
    ./plugins/gitsigns.nix
    ./plugins/fugitive.nix
    ./plugins/git-blame.nix

    # Aesthetic
    ./colorschemes/onedark.nix
    ./plugins/lualine.nix
    ./plugins/rainbow.nix
    ./plugins/colorizer.nix
    ./plugins/todo-comments.nix
  ];

  xdg.configFile."nvim/spell/pt.utf-8.spl".source = nvim-spell-pt;

  xdg.configFile."nvim/init.vim".text = ''
    ${initVimBefore}
    ${initVimAfter}
  '';

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Language specific
      vim-nix # Used mainly for filetype detection
      # Current elixir tree-sitter parser is very laggy when opening files
      vim-elixir
      # React / ts
      vim-prettier
      # Utils
      nvim-web-devicons
      targets-vim
      vim-commentary
      vim-repeat
      vim-sensible
      vim-surround
      vim-tmux-navigator
    ];
  };

  programs.bash.shellAliases = aliases;
  programs.zsh.shellAliases = aliases;
}
