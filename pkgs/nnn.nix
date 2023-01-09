{ pkgs, ... }:

{
  programs.nnn.enable = true;

  # -e flag: Opens text files in the terminal by default
  programs.bash.shellAliases.n = "nnn -e";
}
