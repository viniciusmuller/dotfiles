{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # TODO: Fix the flake on the suckless repository and use its package overrides
    suckless.url = "github:arcticlimer/suckless";

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/master";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, ... } @inputs:
    let
      overlays = with inputs; [
        # TODO: Overlays doesn't seem to be working
        suckless.overlays
        emacs-overlay.overlay
      ];
    in
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
          rec {
            system = "x86_64-linux";
            modules = [
              { nixpkgs.overlays = overlays; }
              ./machines/nixos
              home-manager.nixosModules.home-manager
              {
                home-manager.users.vini = { ... }: {
                  imports = [ nix-doom-emacs.hmModule ];
                };
              }
            ];
            specialArgs = {
              inherit inputs system;
            };
          };

        homeConfigurations = {
          arch = home-manager.lib.homeManagerConfiguration {
            configuration = ./machines/arch;
            system = "x86_64-linux";
            homeDirectory = "/home/vini";
            username = "vini";
          };
        };
      };
}
