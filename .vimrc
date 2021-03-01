set nocompatible
set showcmd
filetype plugin on

"################################################################
"#                          Vim-Plug                            # 
"################################################################

call plug#begin()

" Gruvbox theme
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-commentary'

Plug 'takac/vim-hardtime'

Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'

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

" Exit insert mode on jj  
inoremap jj <Esc>

"################################################################
"#                        Vim-hardtime                          # 
"################################################################

let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1

"################################################################
"#                            Misc             			            #
"################################################################

set wildmode=longest,list
set history=200

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
set incsearch

" Remap identation to Tab/Shift+Tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

