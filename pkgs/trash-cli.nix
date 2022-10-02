{ pkgs, prelude, ... }:

let
  aliases = { rm = "trash-put"; };
in
{
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.bash.shellAliases = aliases;
}
