{
  description = "Personal flake config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, flake-utils, nixpkgs, ... } @inputs:
    let
      # TODO: Figure out how to apply overlays with this new config structure
      # (if I ever # need them).
      overlays = with inputs; [];
      lib = import ./lib inputs;
    in
    {
      nixosConfigurations = {
        nixos = lib.mkHost {
          host = "nixos";
          system = "x86_64-linux";
          username = "vini";
        };
      };

      homeConfigurations =
        let
          system = "x86_64-linux";
          username = "vini";
        in
        {
          arch = lib.mkHome {
            inherit system username;
            name = "arch";
          };
          wsl = lib.mkHome {
            inherit system username;
            name = "wsl";
          };
        };
      # Devshell
    } // flake-utils.lib.eachDefaultSystem
      (
        system: {
          devShell =
            let
              pkgs = nixpkgs.legacyPackages.${system};
            in
            pkgs.mkShell {
              buildInputs = with pkgs; [
                # Nix development dependencies
                rnix-lsp
                nixpkgs-fmt

                # Sway IPC scripts
                rustc
                cargo
                rust-analyzer
                rustfmt
              ];
            };
        }
      );
}
