{ pkgs, config, ... }:

let
  complete-alias = builtins.fetchGit {
    url = "https://github.com/cykerway/complete-alias";
    rev = "b16b183f6bf0029b9714b0e0178b6bd28eda52f3";
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
