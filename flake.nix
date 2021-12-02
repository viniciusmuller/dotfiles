{
  description = "Personal flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, nixpkgs, home-manager, ... } @inputs:
    let
      overlays = with inputs; [
        # TODO: Overlays doesn't seem to be working
      ];

      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays:
        import pkgs { inherit system; };

      pkgs = mkPkgs nixpkgs [ ];
      lib = nixpkgs.lib;

      prelude = {
        mkLuaCode =
          (
            code:
            ''
              lua << EOF
                ${code}
              EOF
            ''
          );

        mkShellAlias = (
          alias: {
            programs.zsh.shellAliases = alias;
            programs.bash.shellAliases = alias;
            programs.fish.shellAliases = alias;
          }
        );
      };
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.users.vini = { ... }: {
              _module.args = {
                inherit prelude;
              };
            };
          }
        ];
        specialArgs = {
          inherit inputs system prelude;
        };
      };

      homeConfigurations = {
        arch = home-manager.lib.homeManagerConfiguration {
          configuration = ./hosts/arch;
          system = "x86_64-linux";
          homeDirectory = "/home/vini";
          username = "vini";
          extraSpecialArgs = { inherit prelude; };
        };

        wsl = home-manager.lib.homeManagerConfiguration {
          configuration = ./hosts/wsl;
          system = "x86_64-linux";
          homeDirectory = "/home/vini";
          username = "vini";
          extraSpecialArgs = { inherit prelude; };
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
                rnix-lsp
                nixpkgs-fmt
              ];
            };
        }
      );
}
