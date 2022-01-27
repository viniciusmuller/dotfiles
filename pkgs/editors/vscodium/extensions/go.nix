{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      golang.go
      # 766b.go-outliner
      # premparihar.gotestexplorer
    ];
  };
}
