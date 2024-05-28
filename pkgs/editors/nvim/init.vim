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
set guifont=JetBrains\ Mono:h11
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
set shortmess+=cI

noremap Y "+y
noremap H ^
noremap L $
nnoremap Q @@
nnoremap <C-p> <C-^>

function! SendToTerminal(cmd)
  " Salva o buffer atual
  let l:current_buffer = bufnr('%')

  " Busca um buffer de terminal
  let l:terminal_buffer = -1
  for buf in getbufinfo({'bufloaded': 1})
    if getbufvar(buf.bufnr, '&buftype') ==# 'terminal'
      let l:terminal_buffer = buf.bufnr
      break
    endif
  endfor

  " Se nenhum buffer de terminal for encontrado, retorna
  if l:terminal_buffer == -1
    echo "No terminal buffer found"
    return
  endif

  " Obter o ID do job do terminal
  let l:job_id = getbufvar(l:terminal_buffer, 'terminal_job_id', -1)
  if l:job_id == -1
    echo "No job found for terminal buffer"
    return
  endif

  " Envia o comando ao terminal
  call jobsend(l:job_id, a:cmd . "\n")

  " Retorna ao buffer original
  exec 'buffer ' . l:current_buffer
endfunction

function! OpenOrReuseTerminal()
  " Save the current window number
  let l:current_win = win_getid()

  " Find an existing terminal buffer
  let l:terminal_buffer = -1
  for buf in getbufinfo({'bufloaded': 1})
    if getbufvar(buf.bufnr, '&buftype') ==# 'terminal'
      let l:terminal_buffer = buf.bufnr
      break
    endif
  endfor

  if l:terminal_buffer == -1
    " No terminal found, open a new one
    vsplit
    exec 'term'
    let l:terminal_buffer = bufnr('%')
  else
    " Terminal found, switch to its window
    let l:terminal_win = bufwinid(l:terminal_buffer)
    if l:terminal_win == -1
      " If terminal buffer is hidden, show it in a new split
      vsplit
      exec 'buffer ' . l:terminal_buffer
    else
      " Otherwise, switch to the window containing the terminal
      call win_gotoid(l:terminal_win)
    endif
  endif

  " Enter insert mode to interact with the terminal
  startinsert
endfunction

" Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <Esc>
nnoremap <C-w>S :call SendToTerminal('echo "hello world!"')<CR>
nnoremap <C-w>V :call OpenOrReuseTerminal()<CR>

nnoremap j gj
nnoremap k gk

nnoremap <C-q> <C-w>q
" nnoremap <C-s> <cmd>update<cr>

" -- Quickfix/Location lists --
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast  | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast  | catch | endtry

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

" Buffers
nnoremap <leader>bd <cmd>bd<cr>

nnoremap <silent> <leader>vQ <cmd>quitall!<cr>
nnoremap <silent> <leader>vq <cmd>quitall<cr>
nnoremap <silent> <leader>vr <cmd>source $MYVIMRC<cr>

nnoremap <C-s> :w<cr>

" Allow the . to execute once for each line of a visual selection
vnoremap . :normal .<cr>

" Highlight trailing whitespaces only in normal mode
autocmd InsertEnter * match None
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
highlight TrailingWhitespace ctermbg=red guibg=red

augroup my_autocommands
  " Remove trailing whitespaces on write
  " au BufWritePre * %s/\s\+$//e
  " Open help windows vertically splitted
  au FileType help wincmd L
  " Highlight on yank (nvim only)
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="HighlightedYankRegion", timeout=50}

  " Handle nix files
  au BufEnter *.nix set ft=nix
  autocmd FileType nix,elixir setlocal commentstring=#\ %s

  au BufEnter *.fs,*.fsi set ft=fsharp
  autocmd FileType fsharp setlocal commentstring=//\ %s
augroup end

augroup numbertoggle
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end

let g:journal_dir = expand('~/.journal')

function! OpenJournal()
  let today = strftime('%d-%m-%Y')

  let dir = g:journal_dir
  if !isdirectory(dir)
    call mkdir(dir, 'p')
  endif

  let filename = dir . '/' . today . '.md'
  if !filereadable(filename)
    call writefile([], filename)
  endif

  execute 'edit ' . filename
  set filetype=markdown
endfunction

nnoremap <leader>oj :call OpenJournal()<CR>
nnoremap <leader>od :edit <C-R>=g:journal_dir<CR><CR>
