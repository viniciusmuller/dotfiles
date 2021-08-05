{ pkgs, prelude, ... }:

let
  aliases = {rm = "trash-put";};
in
{
  home.packages = with pkgs; [
    trash-cli
  ];

  # inherit (prelude.mkShellAlias {rm = "trash-put";});
  programs.zsh.shellAliases = aliases;
  programs.bash.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
}
