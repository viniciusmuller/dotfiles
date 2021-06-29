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

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    jakebecker.elixir-ls
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-elixir-snippets";
      publisher = "florinpatrascu";
      version = "0.2.37";
      sha256 = "05m1wkw34zzd7j0hgl8hdvy3dnn0q4cf83apg1d2nn3z478zid1i";
    }
    {
      name = "elixir-test";
      publisher = "samuel-pordeus";
      version = "1.7.1";
      sha256 = "Z467J7DSQagfooWH124fGvpdmG//NHwG44TiXOsyP3E=";
    }
  ];
}
