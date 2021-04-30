set noexpandtab

command! RunBuffer !gcc -o _tmp_c % && ./_tmp_c && rm _tmp_c
