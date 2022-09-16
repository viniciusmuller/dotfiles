{ pkgs, ... }:

with pkgs;
{
  programs.vscode.extensions = with vscode-extensions; [
    elixir-lsp.vscode-elixir-ls
  ];
}
