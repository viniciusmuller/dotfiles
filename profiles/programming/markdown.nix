{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pandoc
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    yzhang.markdown-all-in-one
  ];
}
