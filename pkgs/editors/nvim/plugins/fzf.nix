{ pkgs, ... }:

let
  fzf-vim = {
    plugin = pkgs.vimPlugins.fzf-vim;
    config = ''
      let $FZF_DEFAULT_COMMAND = 'fd -H'
      let $FZF_DEFAULT_OPTS = '--exact --reverse --bind ctrl-a:select-all'
      let g:fzf_preview_window = ['right:50%', 'ctrl-/']

      nnoremap <leader>,   <cmd>Buffers<cr>
      nnoremap <leader>.   <cmd>GFiles<cr>
      nnoremap <leader>;   <cmd>Rg<cr>
      nnoremap <leader>/   <cmd>Lines<cr>
      nnoremap <leader>ff  <cmd>Files<cr>
      nnoremap <leader>fc  <cmd>Commits<cr>
      nnoremap <leader>fh  <cmd>Helptags<cr>
      nnoremap <leader>fm  <cmd>Apropos<cr>

      " CTRL-A CTRL-Q to select all and build quickfix list
      function! s:build_quickfix_list(lines)
        call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
        copen
        cc
      endfunction

      let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

      " Rg with --hidden
      command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)

      command! -nargs=? Apropos call fzf#run(fzf#wrap({'source': 'apropos .'.shellescape(<q-args>).' | cut -d " " -f 1', 'sink': 'tab Man', 'options': ['--preview', 'MANPAGER=cat MANWIDTH='.(&columns/2-4).' man {}']}))
    '';
  };
in
{
  programs.neovim.plugins = [ fzf-vim ];
  home.packages = with pkgs; [ fzf fd ripgrep ];
}
