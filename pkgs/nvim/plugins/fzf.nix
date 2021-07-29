{ pkgs, ... }:

let
  fzf-vim = {
    plugin = pkgs.vimPlugins.fzf-vim;
    config = ''
      let $FZF_DEFAULT_COMMAND = 'fd -H'
      let $FZF_DEFAULT_OPTS = '--exact --reverse'
      let g:fzf_preview_window = ['right:50%', 'ctrl-/']

      " TODO: Create other keybindings like `<leader>;` for very used commands
      nnoremap <leader>,   <cmd>Buffers<cr>
      nnoremap <leader>.   <cmd>GFiles<cr>
      nnoremap <leader>;   <cmd>Rg<cr>
      nnoremap <leader>ff  <cmd>Files<cr>
      nnoremap <leader>fc  <cmd>Commits<cr>
      nnoremap <leader>fh  <cmd>Helptags<cr>
      nnoremap <leader>fm  <cmd>Apropos<cr>

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
