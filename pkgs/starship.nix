{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$time"
        "$line_break"
        "$status"
        "$character"
      ];
      nix_shell = {
        symbol = "❄️ ";
      };
      time = {
        disabled = false;
      };
    };
  };
}
