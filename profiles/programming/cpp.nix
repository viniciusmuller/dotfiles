{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "competitive-programming-helper";
      publisher = "DivyanshuAgrawal";
      version = "5.7.1";
      sha256 = "0sxx9iznfayai9jdcsm9i4844lagx3k1879fnddvy5qpalrf6nrz";
    }
  ];
}
