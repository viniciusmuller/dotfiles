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
        "$line_break"
        "$status"
        "$character"
      ];
      nix_shell = {
        symbol = "❄️ ";
      };
    };
  };
}
