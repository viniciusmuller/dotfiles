"################################################################
"#                          Vim-Plug                            # 
"################################################################

call plug#begin()

" Gruvbox theme
Plug 'morhetz/gruvbox'

Plug 'preservim/nerdtree'

call plug#end()

"################################################################
"#                           Theme            			            #
"################################################################

" Improve colors on terminal
set termguicolors

colorscheme gruvbox
set bg=dark

"################################################################
"#                          Mappings         			              #
"################################################################

" Save on Ctrl+S
noremap <silent> <C-S> :update<CR>
" Exit insert mode on jj  
inoremap jj <Esc>

"################################################################
"#                            Misc             			            #
"################################################################

" Kitty terminal helper
let &t_ut=''

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Cursor is line zero 
set relativenumber

