{ pkgs, ... }:

let
  customVscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "Ionide-fsharp";
      publisher = "Ionide";
      version = "5.5.6";
      sha256 = "CJf535sRmSnhJ+FZY+QUmeMbtIwqr1pFcZBjPTp4bM0=";
    }
  ];
in
{
  home.packages = with pkgs; [
    dotnet-sdk_5
  ];

  programs.vscode = {
    extensions = customVscodeExtensions;
  };
}
