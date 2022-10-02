{ pkgs, ... }:

{
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
  };

  # -e flag: Opens text files in the terminal by default
  programs.bash.shellAliases.n = "nnn -e";
}
