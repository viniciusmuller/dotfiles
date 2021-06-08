" TODO: convert to Lua

" Compile packer packages on plugins file change
autocmd BufWritePost plugins.lua PackerCompile

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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
