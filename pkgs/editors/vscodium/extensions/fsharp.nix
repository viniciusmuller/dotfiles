{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ionide.ionide-fsharp
    ];
  };
}
