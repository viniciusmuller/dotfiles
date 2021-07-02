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
    ./gamedev.nix
    ./bash.nix
    # ./latex.nix
    # ./fsharp.nix
  ];
}
