{ pkgs, lib, ... }:

let
  conserve = pkgs.rustPlatform.buildRustPackage rec {
    pname = "conserve";
    version = "0.6.10";

    src = pkgs.fetchFromGitHub {
      owner = "sourcefrog";
      repo = "conserve";
      rev = "v0.6.10";
      sha256 = "sha256-U8LWbMwgG2iM2Z+mu/SzsgVpr3aWZgo62LAWVqT3Dsw=";
    };

    cargoSha256 = "sha256-EDkuihS/45v28Nob+VNMGIfNX79xFJvnt0wS9FI7Hjg=";
  };
in
{
  home.packages = [ conserve ];
}
