{ pkgs, ... }:

{
  home.packages = with pkgs; [ fcp ];
  programs.bash.shellAliases.cp = "fcp";
}
