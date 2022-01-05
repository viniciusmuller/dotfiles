{ pkgs, prelude, ... }:

let
  aliases = { rm = "trash-put"; };
in
{
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.zsh.shellAliases = aliases;
  programs.bash.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
}
