{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
    ];
  };

  home.packages = [ pkgs.dotnet-sdk_5 ];
}
