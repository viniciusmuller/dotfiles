{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    suckless.url = "github:arcticlimer/suckless";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      overlays = with inputs; [
        # TODO: Overlays doesn't seem to be working
        nur.overlay
        neovim-nightly-overlay.overlay
        suckless.overlays
      ];
    in
    {
      nixosConfigurations.personal = nixpkgs.lib.nixosSystem
        rec {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            home-manager.nixosModules.home-manager
            ./machines/personal
          ];
          specialArgs = {
            inherit inputs system;
          };
        };
    };
}
