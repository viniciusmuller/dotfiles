{ pkgs, prelude, lib, ... }:

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
    ./plugins/lsp-extensions.nix

    ./lsp/omnisharp.nix
    ./lsp/go.nix
    ./lsp/rust.nix
    # ./lsp/clojure.nix
    ./lsp/elixir.nix
    # ./lsp/godot.nix
    # ./lsp/haskell.nix
    # ./lsp/latex.nix
    # ./lsp/lua.nix
    ./lsp/node.nix
    # ./lsp/python.nix
    # ./lsp/rnix.nix
    # ./lsp/ccls.nix

    # ---- Language specific ----
    ./languages/vim-go.nix
    ./languages/rust-vim.nix

    # ---- General plugins ----

    # Utils
    ./plugins/tree-sitter.nix
    ./plugins/nvim-tree.nix
    ./plugins/cmp.nix
    # ./plugins/which-key.nix
    # ./plugins/neorg.nix
    # ./plugins/trouble.nix
    ./plugins/pears.nix
    # ./plugins/ultisnips.nix

    # ./plugins/fzf-checkout.nix
    # ./plugins/fzf-session.nix
    ./plugins/fzf.nix
    # ./plugins/telescope.nix

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
    ./colorschemes/onedark.nix

    # ./plugins/rainbow.nix
    ./plugins/colorizer.nix
    # ./plugins/orgmode-nvim.nix
    # ./plugins/todo-comments.nix
    # ./plugins/indentline.nix
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      # vim-polyglot
      targets-vim
      vim-commentary
      vim-repeat
      vim-sensible
      vim-surround
      undotree
      vim-vsnip
      friendly-snippets
      vim-tmux-navigator
    ];

    extraConfig = builtins.readFile ./init.vim;
  };

  # inherit (prelude.mkShellAlias aliases);
  programs.bash.shellAliases = aliases;
  programs.zsh.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
}
