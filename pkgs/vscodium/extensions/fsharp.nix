{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ionide.ionide-fsharp
    ];
  };
}
