{ ... } @inputs:

let
  prelude = import ./prelude.nix;
in
rec {
  mkNixpkgs = { system, allowUnfree ? true }:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = allowUnfree;
      # overlays =
      #   (import ../overlays).nixpkgs.overlays
      #   ++ [
      #     inputs.nur.overlay
      #   ];
    };

  mkHost = { host, system ? "x86_64-linux", username, allowUnfree ? true }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system; };
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit pkgs inputs username;
      };

      modules = [
        # host configuration
        (../hosts + "/${host}")

        # home manager
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            # TODO What this does exactly?
            # useUserPackages = true;
            users."${username}" = import (../hosts + "/${host}" + "/home.nix");
            extraSpecialArgs = {
              inherit inputs username pkgs prelude;
            };
          };
        }
      ];
    };

  mkHome = { name, username, system ? "x86_64-linux", allowUnfree ? true }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system; };
      homeDirectory = "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit system username homeDirectory pkgs;
      configuration = (../hosts + "/${name} " + ./home.nix);
      extraSpecialArgs = {
        inherit inputs system username prelude;
      };
    };
}
