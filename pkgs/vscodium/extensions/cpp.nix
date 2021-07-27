{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      divyanshuagrawal.competitive-programming-helper
    ];

    userSettings = {
      "C_Cpp.clang_format_fallbackStyle" = "{BasedOnStyle: Google, IndentWidth: 4}";
    };
  };
}
