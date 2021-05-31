# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local reset='\[\e[0m\]'

    local red='\[\e[0;31m\]'
    local gre='\[\e[0;32m\]'
    local yel='\[\e[0;33m\]'

    PS1+="${yel}\$?${reset} \u@\h ${yel}\w ${red}$(parse_git_branch)${reset}$ "
}

# autocd
shopt -s autocd

# History
export HISTSIZE=100000
export HISTFILESIZE=100000
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# Save and reload the history after each command finishes

# Vi mode
set -o vi
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-p: previous-history'

# Colored man pages on less
export LESS_TERMCAP_mb=$'\e[1;32m'       # begin blinking
export LESS_TERMCAP_md=$'\e[1;32m'       # begin bold
export LESS_TERMCAP_me=$'\e[0m'          # begin underline
export LESS_TERMCAP_se=$'\e[0m'          # begin standout-mode - info box
export LESS_TERMCAP_so=$'\e[01;33m'      # end mode
export LESS_TERMCAP_ue=$'\e[0m'          # end underline
export LESS_TERMCAP_us=$'\e[1;4;31m'     # end standout-mode

# If you don't export a specific path for skinny,
# it will use ~/.local/share/skinny
export SKINNY_PATH=~/.skinny

if [ ! -d $SKINNY_PATH ]; then
  mkdir -p $SKINNY_PATH
  curl https://raw.githubusercontent.com/arcticlimer/skinny/master/skinny.sh \
    -o $SKINNY_PATH/skinny.sh
fi

source $SKINNY_PATH/skinny.sh

skinny src $HOME/.asdf/asdf.sh
skinny src $HOME/.asdf/completions/asdf.bash

skinny src ~/.utils/aliases.sh

skinny github imomaliev/tmux-bash-completion/master/completions/tmux

skinny github cykerway/complete-alias/master/complete_alias
complete -F _complete_alias $( alias | perl -lne 'print "$1" if /^alias ([^=]*)=/' )

# TODO: Find nice completions
skinny github lincheney/fzf-tab-completion/master/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

source_bash_completion() { . ./bash_completion ; }
skinny git https://github.com/scop/bash-completion source_bash_completion

base16_load() { eval "$(./profile_helper.sh)" ; }
skinny git https://github.com/chriskempson/base16-shell base16_load

fzf_path=/usr/share/fzf
skinny src $fzf_path/key-bindings.bash
skinny src $fzf_path/completion.bash

skinny src $fzf_path/completion.bash

skinny cmd zoxide && eval "$(zoxide init bash)"
skinny cmd deno && eval "$(deno completions bash)"
