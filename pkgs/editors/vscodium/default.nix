{ pkgs, ... }:

let
  extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "path-autocomplete";
      publisher = "ionutvmi";
      version = "1.17.1";
      sha256 = "Qxnlf9Jrd0/qLB9gXilIDGbEXAshjuHncAxpcDndnlo=";
    }
  ];
in
{
  imports = [
    # ./extensions/bash.nix
    # ./extensions/cpp.nix
    # ./extensions/rust.nix
    ./extensions/elixir.nix
    # ./extensions/fsharp.nix
    # ./extensions/unity.nix
    # ./extensions/latex.nix
    # ./extensions/haskell.nix
    # ./extensions/nix.nix
    # ./extensions/markdown.nix
    # ./extensions/toml.nix
    # ./extensions/vspacecode
    # ./extensions/go.nix
    # ./extensions/liveshare.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = import ./settings.nix;
    # keybindings = import ./keybindings.nix;
    extensions = with pkgs.vscode-extensions; [
      ionide.ionide-fsharp
      ms-vsliveshare.vsliveshare
      github.github-vscode-theme
      pkief.material-icon-theme
      usernamehw.errorlens
      vscodevim.vim
    ] ++ extensions;
  };
}
