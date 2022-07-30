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
      # TODO: Find out which package is using this electron version
      config.permittedInsecurePackages = [
        "electron-13.6.9"
      ];
    };

  mkHost =
    { host
    , username
    , system ? "x86_64-linux"
    , allowUnfree ? true
    , overlays ? [ ]
    , nixosModules ? [ ]
    , homeModules ? [ ]
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

      modules = nixosModules ++ [
        (../hosts + "/${host}")
        inputs.home-manager.nixosModules.home-manager
        # {
        # home-manager = {
        # };
        # }
        {
          home = {
            inherit inputs username pkgs prelude colorscheme;
            users."${username}" = {
              imports = [ (../hosts + "/${host}/home.nix") ] ++ homeModules;
            };
          };
        }
      ];
    };

  mkHome =
    { name
    , username
    , system ? "x86_64-linux"
    , stateVersion ? "21.11"
    , allowUnfree ? true
    , overlays ? [ ]
    , modules ? [ ]
    , colorscheme ? inputs.nix-colors.colorSchemes.tokyonight
    }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system overlays; };
      homeDirectory = "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      # inherit system username homeDirectory pkgs;
      inherit pkgs;

      modules = [
        {
          home = {
            inherit username homeDirectory stateVersion;
          };
        }
        (../home-configurations + "/${name}")
      ] ++ modules;
      extraSpecialArgs = {
        inherit inputs system username prelude colorscheme;
      };
    };
}
