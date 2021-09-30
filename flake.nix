{
  description = "Personal flake config";

  inputs = {
    # TODO: Use upstream when gigalixir gets merged
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:superherointj/nixpkgs/package-pythonPackages.gigalixir-1.2.3";
    flake-utils.url = "github:numtide/flake-utils";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:arcticlimer/home-manager/add-neovim-initextra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/master";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
  };

  outputs = { self, flake-utils, devshell, nixpkgs, home-manager, nix-doom-emacs, ... } @inputs:
    let
      overlays = with inputs; [
        # TODO: Overlays doesn't seem to be working
        emacs-overlay.overlay
      ];

      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays:
        import pkgs { inherit system; };

      pkgs = mkPkgs nixpkgs [];
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
                imports = [ nix-doom-emacs.hmModule ];
                _module.args = {
                  inherit prelude;
                };
              };
            }
          ];
          specialArgs = {
            # We pass prelude here
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
                pkgs = import nixpkgs {
                  inherit system;
                  overlays = [ devshell.overlay ];
                };
              in
                pkgs.devshell.mkShell {
                  imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
                };
          }
        );
    }

# {
#   devShell."${system}" = pkgs.mkShell {
#     buildInputs = with pkgs; [
#       nixpkgs-fmt
#       rnix-lsp
#     ];
#   };
# }
# }
