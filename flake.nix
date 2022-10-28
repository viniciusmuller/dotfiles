{
  description = "Personal flake config";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Misc
    suckless.url = "github:arcticlimer/suckless";
    nix-colors.url = "github:misterio77/nix-colors";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs, nix-colors, nixpkgs-master, ... } @inputs:
    let
      lib = import ./lib inputs;
      devShells = flake-utils.lib.eachDefaultSystem (
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
    in
    {
      nixosConfigurations = {
        nixos = let 
          system = "x86_64-linux";
          pkgs-master = lib.mkNixpkgs {
            inherit system;
            nixpkgs = nixpkgs-master;
          };
          discord-overlay = final: prev: {
            discord = pkgs-master.discord;
          };
        in lib.mkHost {
          inherit system;
          host = "nixos";
          username = "vini";
          overlays = [
            inputs.suckless.overlays
            discord-overlay
          ];
          homeModules = [
            inputs.nix-colors.homeManagerModule
          ];
          colorscheme = inputs.nix-colors.colorSchemes.nord;
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
          box = lib.mkHome {
            inherit username;
            system = "aarch64-linux";
            name = "box";
          };
        };
      templates = import ./templates;
    } // devShells;
}
