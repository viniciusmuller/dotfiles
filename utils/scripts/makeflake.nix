{ pkgs, ... }:

let
  makeflake = pkgs.writeShellScriptBin "makeflake" ''
    system="\''${system}" # Don't change this

    if [ ! -f ./.envrc ]; then
      echo "use flake" > .envrc
    fi

    if [ ! -f ./flake.nix ]; then
    cat << EOT >> flake.nix
      {
        description = "TODO: Add description";
        inputs.flake-utils.url = "github:numtide/flake-utils";

        outputs = { self, nixpkgs, flake-utils }:
          flake-utils.lib.eachDefaultSystem (system:
            let pkgs = nixpkgs.legacyPackages.''${system}; in
            rec {
              devShell = pkgs.mkShell {
                buildInputs = with pkgs; [
                  # TODO: Add development dependencies
                ];
              };
              defaultPackage = pkgs.hello;
            }
         );
      }
    EOT
    fi
  '';
in
{
  home.packages = [ makeflake ];
}
