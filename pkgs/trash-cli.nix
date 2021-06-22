{ pkgs, ... }:

{
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.bash.shellAliases = {
    rm = "trash-put";
  };
}
