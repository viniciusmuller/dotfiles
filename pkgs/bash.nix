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
  ble-sh = pkgs.fetchFromGitHub {
    author = "akinomyoga";
    repo = "ble.sh";
    rev = "e5d8d00cf52bb899af0ecab563be12dfc11451ba";
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
      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
      }

      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\e[91m\]\$(parse_git_branch)\[\033[00m\]\$ "

      # --- GPG ---
      export GPG_TTY=$(tty)

      # --- Vi mode ---
      set -o vi
      bind -m vi-insert 'Control-l: clear-screen'

      # --- Complete aliases ---
      . ${complete-alias}/complete_alias
      complete -F _complete_alias $( \
        alias | perl -lne 'print "$1 " if /^alias ([^=]*)=/' )

      # --- Tab completion ---
      . ${tab-completion}/bash/fzf-bash-completion.sh
      bind -x '"\t": fzf_bash_completion'

      # --- Colored man pages ---
      export LESS_TERMCAP_mb=$'\e[1;32m'
      export LESS_TERMCAP_md=$'\e[1;32m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[01;33m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;4;31m'
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
      ns = "nix-shell -p";
      nq = "nix search nixpkgs";
      cvi = "convco commit --interactive";
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    FZF_DEFAULT_OPTS = ''--prompt \" λ \"'';
  };
}
