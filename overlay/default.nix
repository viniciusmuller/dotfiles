{ inputs, ... }:

final: prev: {
  # Custom packages
  # dwarf-fortress-custom =
  #   inputs.local-nixpkgs.legacyPackages.${final.system}.dwarf-fortress-packages.dwarf-fortress-full;
  # cli-tools = import ../pkgs/cli-tools.nix { pkgs = final; };
  # fzfpods = import ../pkgs/fzfpods.nix { pkgs = prev; };
}
