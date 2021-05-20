" TODO: convert to Lua

" completion-nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
imap <silent> <cr> <Plug>(completion_trigger)

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Compile packer packages on plugins file change
autocmd BufWritePost plugins.lua PackerCompile

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

augroup my_augroup
  " Meaningful backup name, ex: filename@2015-04-05.14:59
  au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
augroup end

augroup ft_detection
  au BufNewFile,BufRead *.nix set ft=nix
  au BufNewFile,BufRead *.ex,*.exs,*.eex set ft=elixir
augroup end

function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction

" Require the lua config
lua require('init')
