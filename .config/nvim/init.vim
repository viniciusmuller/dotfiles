" TODO: convert to Lua

" completion-nvim

" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" let g:completion_matching_ignore_case = 1
" let g:completion_timer_cycle = 50 "default value is 80
" let g:completion_trigger_character = ['.', '::']

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
imap <silent> <cr> <Plug>(completion_trigger)

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

" Add nvim-web-devicons to startify
lua << EOF
function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end
EOF

augroup my_augroup
  " Meaningful backup name, ex: filename@2015-04-05.14:59
  au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
augroup end

function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction

" Require the lua config
lua require('init')
