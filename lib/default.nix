{ ... } @inputs:

let
  prelude = import ./prelude.nix;
in
rec {
  mkNixpkgs =
    { system
    , nixpkgs ? inputs.nixpkgs
    , allowUnfree ? true
    , overlays ? [ ]
    }:
    import nixpkgs {
      inherit system;
      overlays = [
        (import ../overlay { inherit inputs; })
      ] ++ overlays;
      config.allowUnfree = allowUnfree;
    };

  mkHost =
    { host
    , username
    , extraUsers ? [ ]
    , system ? "x86_64-linux"
    , allowUnfree ? true
    , overlays ? [ ]
    , nixosModules ? [ ]
    , homeModules ? [ ]
    , colorscheme ? inputs.nix-colors.colorSchemes.tokyonight
    }:
    let
      pkgs = mkNixpkgs { inherit allowUnfree system overlays; };
      extraUserConfigs = builtins.foldl' (acc: extraUser: acc // {
              ${extraUser} = {
                imports = [ (../hosts + "/${host}/${extraUser}.nix") ] ++ homeModules;
              };
            }) {} extraUsers;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit pkgs inputs username colorscheme;
      };

      modules = nixosModules ++ [
        (../hosts + "/${host}")
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            users = extraUserConfigs // {
              ${username} = {
                imports = [ (../hosts + "/${host}/home.nix") ] ++ homeModules;
              };
            };

            extraSpecialArgs = {
              inherit inputs username pkgs prelude;

              colorscheme = {
                colors = colorscheme.palette;
              };
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
        inherit inputs system username prelude;

        colorscheme = {
          colors = colorscheme.palette;
        };
      };
    };
}
