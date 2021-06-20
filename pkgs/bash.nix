{ pkgs, config, ... }:

{
  programs = {
    bash = {
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

      bashrcExtra = "
      # Vi mode
      set -o vi
      bind -m vi-insert 'Control-l: clear-screen'
      bind -m vi-insert 'Control-p: previous-history'
      bind -m vi-insert 'Control-n: next-history'
      ";

      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
      ];

      shellAliases = {
        ls = "exa";
        c  = "clear";
        rb = "sudo nixos-rebuild switch";
      };

      sessionVariables = {
        EDITOR = "vim";
      };
    };
  };
}
