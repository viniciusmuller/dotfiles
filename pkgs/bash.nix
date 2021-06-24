{ pkgs, config, ... }:

let
  complete-alias = builtins.fetchGit {
    url = "https://github.com/cykerway/complete-alias";
    rev = "b16b183f6bf0029b9714b0e0178b6bd28eda52f3";
  };
  tab-completion = builtins.fetchGit {
    url = "https://github.com/lincheney/fzf-tab-completion";
    rev = "53eb325f573265a6105c9bd0aa56cd865c4e14b7";
  };
in
{
  programs.bash = {
    enable = true;
    historySize = 10000;
    shellOptions = [
      # Auto cd to directories
      "autocd"

      # Append to history file rather than replacing it.
      "histappend"

      # check the window size after each command and, if
      # necessary, update the values of LINES and COLUMNS.
      "checkwinsize"

      # Extended globbing.
      "extglob"
      "globstar"

      # Warn if closing shell with running jobs.
      "checkjobs"
    ];

    initExtra = ''
      # Vi mode
      set -o vi
      bind -m vi-insert 'Control-l: clear-screen'

      # Complete aliases
      . ${complete-alias}/complete_alias
      complete -F _complete_alias $( \
        alias | perl -lne 'print "$1 " if /^alias ([^=]*)=/' )

      # Tab completion
      . ${tab-completion}/bash/fzf-bash-completion.sh
      bind -x '"\t": fzf_bash_completion'

      # ------ Set bash prompt ------

      git_branch() {
        git branch 2>/dev/null | grep '^*' | colrm 1 2
      }

      # Set Colors
      BLUE='\001\033[01;34m\002'
      YELLOW='\001\033[01;33m\002'
      RED='\001\033[01;31m\002'
      GREEN='\001\033[01;32m\002'
      RESET='\001\033[00m\002'

      # Use PROMPT_COMMAND to get Return Status
      function prompt_command {
        RET=$?
        if [[ $RET -ne 0 ]]; then
          PS1=$RED$RET
        else
          PS1=$GREEN$RET
        fi

        # TODO: Don't output nothing on the branch slot if not in a branch
        PS1+='$(echo -ne " $BLUE\w $RED$(git_branch) $YELLOW>$GREEN>$RED> $RESET")'
      }
      PROMPT_COMMAND=prompt_command
    '';

    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];

    shellAliases = {
      c = "clear";
      b = "cd -";
      se = "sudoedit";
      ns = "nix-shell";
    };

    sessionVariables = {
      EDITOR = "vim";
      FZF_DEFAULT_OPTS = ''--prompt \" λ \"'';
    };
  };
}
