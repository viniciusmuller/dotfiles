{ inputs, system, ... }:

final: prev: {
  # Custom packages
  dwarf-fortress-custom =
    inputs.local-nixpkgs.${final.system}.dwarf-fortress-full;
  # cli-tools = import ../pkgs/cli-tools.nix { pkgs = final; };
  # fzfpods = import ../pkgs/fzfpods.nix { pkgs = prev; };
}
