{
  # nix flake init -t github:arcticlimer/dotfiles#templates.rust
  rust = {
    description = "Rust Project Template";
    path = ./rust;
  };

  # nix flake init -t github:arcticlimer/dotfiles#templates.go
  go = {
    description = "Go Project Template";
    path = ./go;
  };

  # nix flake init -t github:arcticlimer/dotfiles#templates.elixir
  elixir = {
    description = "Elixir Project Template";
    path = ./elixir;
  };

  # nix flake init -t github:arcticlimer/dotfiles#templates.fsharp
  fsharp = {
    description = "Fsharp Project Template";
    path = ./fsharp;
  };

  # nix flake init -t github:arcticlimer/dotfiles#templates.basic
  basic = {
    description = "A very basic flake";
    path = ./basic;
  };
}
