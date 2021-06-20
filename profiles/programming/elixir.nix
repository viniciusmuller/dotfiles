{ config, pkgs, ... }:

with pkgs;
let
  elixir = (beam.packagesWith erlangR24).elixir.override {
    version = "1.12.1";
    sha256 = "sha256-gRgGXb4btMriQwT/pRIYOJt+NM7rtYBd+A3SKfowC7k=";
    minimumOTPVersion = "22";
  };
in
{
  home.packages = [
    glibcLocales
    elixir
  ];
}