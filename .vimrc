"################################################################
"#                         Vim-Plug                             #
"################################################################

call plug#begin()

" Gruvbox theme
Plug 'morhetz/gruvbox'

Plug 'preservim/nerdtree'

call plug#end()

"################################################################
"#                          Theme            			#
"################################################################

set termguicolors
colorscheme gruvbox
set bg=dark

" Kitty terminal helper
let &t_ut=''

set tabstop=2
set shiftwidth=2
set expandtab

