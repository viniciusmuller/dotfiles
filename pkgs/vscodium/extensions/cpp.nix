{ pkgs, ... }:

let
  customVscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "competitive-programming-helper";
      publisher = "DivyanshuAgrawal";
      version = "5.7.1";
      sha256 = "0sxx9iznfayai9jdcsm9i4844lagx3k1879fnddvy5qpalrf6nrz";
    }
  ];
in
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
    ] ++ customVscodeExtensions;

    userSettings = {
      "C_Cpp.clang_format_fallbackStyle" = "{BasedOnStyle: Google, IndentWidth: 4}";
    };
  };
}
