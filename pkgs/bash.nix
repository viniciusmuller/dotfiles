{ pkgs, config, ... }:

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

    initExtra = "
    # Vi mode
    set -o vi
    bind -m vi-insert 'Control-l: clear-screen'
    ";

    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];

    shellAliases = {
      c = "clear";
      b = "cd -";
      se = "sudoedit";
    };

    sessionVariables = {
      EDITOR = "vim";
    };
  };
}
