{
  description = "A very basic flake";

  inputs = {
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:arcticlimer/home-manager";
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
      prelude = {
        mkLuaCode =
          (code:
            ''
              lua << EOF
                ${code}
              EOF
            '');

        mkShellAlias = (alias: alias);
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.users.vini = { ... }: {
              imports = [ nix-doom-emacs.hmModule ];
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
        };

        wsl = home-manager.lib.homeManagerConfiguration {
          configuration = ./hosts/wsl;
          system = "x86_64-linux";
          homeDirectory = "/home/vini";
          username = "vini";
        };
      };
    };
}
