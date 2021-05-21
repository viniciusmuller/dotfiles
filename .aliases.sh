alias v="vim"
alias vf="vifm"
alias nv="nvim"

alias se="sudoedit"

alias gs="git status"
alias gc="git commit"

alias ls="exa"

alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias restore="trash-restore"

alias mc="make clean"
alias mk="make"

alias pd="popd"

alias tl="tmux ls"
alias ta="tmux attach -t"
alias tn="tmux new -s"
alias tk="tmux kill-session -t"

alias pacs="sudo pacman -S"
alias pacup="sudo pacman -Syu"
alias pacr="sudo pacman -Rns"
alias pacf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacq="pacman -Q"

alias yays="yay -S"
alias yayf="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias yayr="yay -Rns"
alias yayup="yay -Syu"

