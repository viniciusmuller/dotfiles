{ pkgs, ... }:

{
  home.packages = with pkgs; [ fcp ];
  programs.zsh.shellAliases.cp = "fcp";
  programs.bash.shellAliases.cp = "fcp";
  programs.fish.shellAliases.cp = "fcp";
}
