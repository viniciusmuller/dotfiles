{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ rpg-cli ];
  programs.bash.shellAliases.rpg = "rpg-cli";
}
