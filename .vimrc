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
" Clear search highlight on pressing <esc>
" noremap <esc> :noh<CR><esc> 

"################################################################
"#                            Misc             			            #
"################################################################

" Kitty terminal helper
let &t_ut=''

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

set relativenumber
set number

set linebreak

" Search options:
set ignorecase 
" Highlight matches
set hlsearch

" Remap identation to Tab/Shift+Tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
