{ ... } @inputs:

let
  prelude = import ./prelude.nix;
in
rec {
  mkNixpkgs =
    { system
    , allowUnfree ? true
    , overlays ? [ ]
    }:
    import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = allowUnfree;
    };

  mkHost =
    { host
    , username
    , system ? "x86_64-linux"
    , allowUnfree ? true
    , overlays ? [ ]
    , colorscheme ? inputs.nix-colors.colorSchemes.tokyonight
    }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system overlays; };
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit pkgs inputs username colorscheme;
      };

      modules = [
        (../hosts + "/${host}")
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            users."${username}" = import (../hosts + "/${host}" + "/home.nix");
            extraSpecialArgs = {
              inherit inputs username pkgs prelude colorscheme;
            };
          };
        }
      ];
    };

  mkHome =
    { name
    , username
    , system ? "x86_64-linux"
    , allowUnfree ? true
    , overlays ? [ ]
    , colorscheme ? inputs.nix-colors.colorSchemes.tokyonight
    }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system overlays; };
      homeDirectory = "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit system username homeDirectory pkgs;
      configuration = (../home-configurations + "/${name}");
      extraSpecialArgs = {
        inherit inputs system username prelude colorscheme;
      };
    };
}
