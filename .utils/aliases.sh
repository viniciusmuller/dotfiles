alias l='ls -lah'
alias c='clear'

alias b="cd -"

alias v="vim"
alias vf="vifm"
alias nv="nvim"

alias se="sudoedit"

# git
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gl="git log"
alias gcl="git clone"
alias gco="git checkout"
alias glog="git log --oneline"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gr="git remote"
alias gp="git push"
alias gb="git branch"
alias grv="git remote -v"
alias gsh="git show"

# asdf
alias apa="asdf plugin-add"
alias apr="asdf plugin-remove"
alias apl="asdf plugin-list"
alias apu="asdf plugin-update"
alias ai="asdf install"
alias ag="asdf global"
alias al="asdf local"
alias au="asdf uninstall"

alias ls="exa"

alias rm="trash-put"
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
alias paco="pacman -Qo"

alias yays="yay -S"
alias yayf="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias yayr="yay -Rns"
alias yayup="yay -Syu"

