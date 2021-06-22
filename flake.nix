{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs.overlays = with inputs; [
            nur.overlay
            neovim-nightly-overlay.overlay
          ];
        }
        home-manager.nixosModules.home-manager
        ./machines/personal
      ];
      specialArgs = {
        inherit inputs system;
      };
    };
  };
}
