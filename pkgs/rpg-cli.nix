{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ rpg-cli ];
  programs.bash.shellAliases.rpg = "rpg-cli";
  programs.fish.shellAliases.rpg = "rpg-cli";
  programs.zsh.shellAliases.rpg = "rpg-cli";
}
