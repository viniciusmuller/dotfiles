{ pkgs, ... }:

let
  customVscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "competitive-programming-helper";
      publisher = "DivyanshuAgrawal";
      version = "5.8.5";
      sha256 = "25v2tdAX7fVl2B5nvOIKN9vP1G5rA0G67CiDQn9n9Uc=";
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
