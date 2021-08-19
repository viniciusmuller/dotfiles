{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    ms-vsliveshare.vsliveshare
  ];

  programs.vscode.userSettings = {
    "liveshare.guestApprovalRequired" = true;
  };
}
