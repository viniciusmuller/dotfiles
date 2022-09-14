{
  description = "Basic F# flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
       devShell = with pkgs; mkShell {
          buildInputs = [
            dotnet-sdk_6
            icu
          ];
          shellHook = ''
            export DOTNET_ROOT=${dotnet-sdk_6}
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib.makeLibraryPath [ icu ]}
          '';
        };
      });
}
