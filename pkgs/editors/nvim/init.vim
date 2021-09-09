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
set nomodeline
set autoread
set completeopt=menuone,noselect
set pumheight=10 " Max number of items in autocompletion popup
set pumwidth=25
set updatetime=400
" Some plugin is removing `-` from the separators, for now lets just get it back.
set iskeyword-=-
" Don't auto line break when inserting text
set formatoptions-=t
set shortmess+=Ic
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
  let autosave_blacklist = ['NvimTree', 'help' ]
  if index(autosave_blacklist, &ft) < 0 && w:autosave == 1 && &modifiable
    silent update
  endif
endfunction

augroup myautosave
  autocmd InsertLeave,TextChanged * call s:autosave()
  autocmd BufWinEnter * let w:autosave = g:autosave_autostart
augroup end

command ToggleAutoSave let w:autosave = w:autosave ? 0 : 1
