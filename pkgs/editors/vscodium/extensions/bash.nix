{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs.vscode-extensions;
    [
      timonwong.shellcheck
    ];
}
