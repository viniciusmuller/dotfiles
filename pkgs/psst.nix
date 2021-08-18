{ pkgs, ... }:

let
  # TODO: This boi doesn't work
  psst = pkgs.rustPlatform.buildRustPackage rec {
  pname = "psst";
  version = "0.1.0";

  src = pkgs.fetchgit {
    url = "git://github.com/jpochyla/psst";
    rev = "e6e3cfafa547ea188e23145b501e669f62558bf4";
    sha256 = "sha256-vNXXROWsKmanBJAzm3m6jiNM+uqtxx/s89KpR3wEpCY=";
    deepClone = true;
  };

  # libssl
  buildInputs = with pkgs; [ dbus gcc glib cairo ];
  nativeBuildInputs = with pkgs; [ pkg-config ];
  cargoSha256 = "sha256-c9813Y4cSEkgTXvGPD4kAHK+lWqFXOePqr786p6DRbg=";

  installPhase = ''
    git submodule --init --recursive
  '';
};
in
{
  home.packages = [ psst ];
}
