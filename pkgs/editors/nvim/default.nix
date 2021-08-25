{ config, pkgs, prelude, ... }:

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

  my-noplugin-directoryexplorer = ''
    let g:netrw_banner = 0
    let g:netrw_winsize = 20
    let g:netrw_liststyle = 3
    let g:netrw_altv = 1
    let g:netrw_bufsettings = 'relativenumber'

    let g:NetrwIsOpen=0
    function! ToggleNetrw()
        if g:NetrwIsOpen
            let i = bufnr("$")
            while (i >= 1)
                if (getbufvar(i, "&filetype") == "netrw")
                    silent exe "bwipeout " . i
                endif
                let i-=1
            endwhile
            let g:NetrwIsOpen=0
        else
            let g:NetrwIsOpen=1
            silent Lexplore
        endif
    endfunction

    " Add your own mapping. For example:
    nnoremap tn <cmd>call ToggleNetrw()<cr>

    augroup netrw_mappings
      autocmd filetype netrw call NetrwMapping()
    augroup END

    function! CreateInPreview()
      let l:filename = input("Please enter filename: ")
      execute 'vsp ' . b:netrw_curdir.'/'.l:filename
    endf

    function! NetrwMapping()
      nnoremap <buffer> tn :call ToggleNetrw()<cr>
      nnoremap <buffer> % :call CreateInPreview()<cr>
      nnoremap <buffer> <c-l> <c-w>l
    endfunction
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
in
{
  imports = [
    # ---- Language server protocol ----
    # ./plugins/lsp-signature.nix
    ./plugins/lspconfig.nix

    ./lsp/omnisharp.nix
    ./lsp/go.nix
    ./lsp/rust.nix
    # ./lsp/clojure.nix
    # ./lsp/elixir.nix
    # ./lsp/godot.nix
    # ./lsp/haskell.nix
    # ./lsp/latex.nix
    # ./lsp/lua.nix
    # ./lsp/node.nix
    ./lsp/python.nix
    # ./lsp/rnix.nix
    # ./lsp/ccls.nix

    # ---- Language specific ----
    ./languages/vim-go.nix
    # ./languages/rust-vim.nix

    # ---- General plugins ----

    # Utils
    # ./plugins/tree-sitter.nix
    ./plugins/nvim-tree.nix
    # ./plugins/compe.nix
    ./plugins/cmp.nix
    # ./plugins/which-key.nix
    # ./plugins/neorg.nix
    # ./plugins/trouble.nix
    ./plugins/autopairs.nix
    # ./plugins/ultisnips.nix
    ./plugins/fzf-checkout.nix
    ./plugins/fzf-session.nix
    ./plugins/fzf.nix
    # ./plugins/projectionist.nix
    ./plugins/vim-test.nix
    ./plugins/togglelist.nix
    ./plugins/closetag.nix
    # ./plugins/visual-multi.nix
    ./plugins/slash.nix
    # ./plugins/neomake.nix

    # Seems interesting but are currently broken with nix
    # ./plugins/coq.nix
    # ./plugins/chadtree.nix

    # ./plugins/conjure.nix

    # Debugging
    # ./plugins/dap.nix
    # ./plugins/dap-ui.nix

    # Git
    ./plugins/gitsigns.nix
    # ./plugins/fugitive.nix
    # ./plugins/git-blame.nix

    # Aesthetic
    ./colorschemes/tokyonight.nix

    # This imports a module which uses `prelude` and gives `attribute prelude missing`
    # ./plugins/lualine.nix

    # ./plugins/rainbow.nix
    ./plugins/colorizer.nix
    # ./plugins/orgmode-nvim.nix
    # ./plugins/autosave.nix
    # ./plugins/todo-comments.nix
    # ./plugins/indentline.nix
  ];

  xdg.configFile."nvim/spell/pt.utf-8.spl".source = nvim-spell-pt;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # vim-prettier
      # undotree
      nvim-web-devicons
      vim-polyglot
      targets-vim
      tagalong-vim
      vim-commentary
      vim-repeat
      vim-sensible
      vim-surround
      vim-vsnip
      friendly-snippets
      emmet-vim
      vim-tmux-navigator
    ];

    initExtra = ''
      let mapleader = " "
      let maplocalleader = ","
    '';

    extraConfig = ''
      set undofile
      set noshowmode
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
      set iskeyword-=-
      " Don't auto line break when inserting text
      set formatoptions-=t
      set shortmess+=I
      " set listchars=tab:»\ ,space:·,eol:¬
      " set list

      noremap Y "+y
      noremap H ^
      noremap L $
      nnoremap Q @@

      nnoremap <C-q> <C-w>q
      " nnoremap <C-s> <cmd>update<cr>

      " -- Quickfix/Location lists --
      command Cnext try | cnext | catch | cfirst | catch | endtry
      command Cprev try | cprev | catch | clast  | catch | endtry
      command Lnext try | lnext | catch | lfirst | catch | endtry
      command Lprev try | lprev | catch | llast  | catch | endtry

      nnoremap [q <cmd>Cprev<cr>
      nnoremap ]q <cmd>Cnext<cr>
      nnoremap [Q <cmd>cfirst<cr>
      nnoremap ]Q <cmd>clast<cr>

      nnoremap [w <cmd>Lprev<cr>
      nnoremap ]w <cmd>Lnext<cr>
      nnoremap [W <cmd>lfirst<cr>
      nnoremap ]W <cmd>llast<cr>

      " Tabs
      nnoremap <leader>to :tabnew<space>
      nnoremap <leader>tq :tabclose<cr>
      nnoremap <silent>g< :tabmove tabpagenr() - 2<cr>
      nnoremap <silent>g> :tabmove tabpagenr() + 1<cr>

      nnoremap <silent> <leader>vQ <cmd>quitall!<cr>
      nnoremap <silent> <leader>vq <cmd>quitall<cr>
      nnoremap <silent> <leader>vr <cmd>source $MYVIMRC<cr>

      augroup my_autocommands
        " Remove trailing whitespaces on write
        au BufWritePre * %s/\s\+$//e
        " Open help windows vertically splitted
        au FileType help wincmd L
        " Highlight on yank (nvim only)
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedYankRegion", timeout=50}
      augroup end

      let g:autosave_autostart = 1
      function s:autosave()
        let autosave_blacklist = ['NvimTree', 'help']
        if index(autosave_blacklist, &ft) < 0 && w:autosave == 1 && &modifiable
          silent write
        endif
      endfunction

      augroup myautosave
        autocmd InsertLeave,TextChanged * call s:autosave()
        autocmd BufWinEnter * let w:autosave = g:autosave_autostart
      augroup end

      command ToggleAutoSave let w:autosave = w:autosave ? 0 : 1

      function! SynStack()
        if !exists("*synstack")
          return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
      endfunc

      nnoremap <leader>q :call SynStack()<cr>
    '';
  };

  # inherit (prelude.mkShellAlias aliases);
  programs.bash.shellAliases = aliases;
  programs.zsh.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
}
