{ pkgs, ... }:

let
  termbin = "${pkgs.netcat}/bin/nc termbin.com 9999";
in
{
  programs.bash.shellAliases.tb = termbin;
  programs.fish.shellAliases.tb = termbin;
  programs.zsh.shellAliases.tb = termbin;
}
