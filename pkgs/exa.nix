{ pkgs, ... }:

{
  programs.exa = {
    enable = true;
  };

  programs.bash.shellAliases = {
    ls = "exa";
    l = "ls -la";
  };
}
