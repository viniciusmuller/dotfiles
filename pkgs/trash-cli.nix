{ pkgs, ... }:

{
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.bash.shellAliases = { rm = "trash-put"; };
  programs.zsh.shellAliases = { rm = "trash-put"; };
}
