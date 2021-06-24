{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python39
    poetry
  ];

  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      # ms-python.python
    ];

    # userSettings = {
    #     "python.showStartPage" = false;
    # };
  };
}
