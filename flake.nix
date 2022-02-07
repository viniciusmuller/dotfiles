{
  description = "Personal flake config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    suckless.url = "github:arcticlimer/suckless";
  };

  outputs = { self, flake-utils, nixpkgs, nur, nix-colors, ... } @inputs:
    let
      lib = import ./lib inputs;
    in
    {
      nixosConfigurations = {
        nixos = lib.mkHost {
          host = "nixos";
          system = "x86_64-linux";
          username = "vini";
          overlays = [ nur.overlay inputs.suckless.overlays ];
          colorscheme = inputs.nix-colors.colorSchemes.tokyonight;
        };
      };

      homeConfigurations =
        let
          system = "x86_64-linux";
          username = "vini";
        in
        {
          manjaro = lib.mkHome {
            inherit system username;
            name = "manjaro";
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
              ];
            };
        }
      );
}
