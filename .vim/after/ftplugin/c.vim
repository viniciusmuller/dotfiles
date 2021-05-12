set noexpandtab
set tabstop=4

command! RunBuffer !gcc -o _tmp_c % && ./_tmp_c && rm _tmp_c
