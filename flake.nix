{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nur.url = "github:nix-community/nur";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # TODO: Fix the flake on the suckless repository and use its package overrides
    suckless.url = "github:arcticlimer/suckless";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, ... } @inputs:
    let
      overlays = with inputs; [
        # TODO: Overlays doesn't seem to be working
        # nur.overlay
        # neovim-nightly-overlay.overlay
        suckless.overlays
      ];
    in
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
          rec {
            system = "x86_64-linux";
            modules = [
              { nixpkgs.overlays = overlays; }
              # home-manager.nixosModules.home-manager
              ./machines/personal
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
      };
}
