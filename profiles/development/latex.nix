{ pkgs, ... }:

{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    james-yu.latex-workshop
  ];

  programs.vscode.userSettings = {
    "latex-workshop.view.pdf.viewer" = "browser";
  };
}
