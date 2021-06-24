{ config, pkgs, ... }:

{
  imports = [
    ./cpp.nix
    ./nix.nix
    ./elixir.nix
    ./rust.nix
    ./python.nix
    ./haskell.nix
    ./node.nix
    ./toml.nix
    ./markdown.nix
    ./bash.nix
  ];

  home.packages = with pkgs; [
    jetbrains-mono # Jetbrains Mono font
  ];
}
