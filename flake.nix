{
  description = "Personal flake config";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Misc
    suckless.url = "github:arcticlimer/suckless";
    nix-colors.url = "github:misterio77/nix-colors";
    flake-utils.url = "github:numtide/flake-utils";

    # Emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs = {
      inputs.doom-emacs.url = "github:hlissner/doom-emacs";
      url = "github:nix-community/nix-doom-emacs";
    };
  };

  outputs = { self, flake-utils, nixpkgs, nix-colors, ... } @inputs:
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
        nixos = lib.mkHost {
          host = "nixos";
          system = "x86_64-linux";
          username = "vini";
          overlays = [
            inputs.emacs-overlay.overlay
            inputs.suckless.overlays
          ];
          homeModules = [
            inputs.nix-doom-emacs.hmModule
            inputs.nix-colors.homeManagerModule
          ];
          colorscheme = inputs.nix-colors.colorSchemes.tokyonight;
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
      templates = import ./templates;
    } // devShells;
}
