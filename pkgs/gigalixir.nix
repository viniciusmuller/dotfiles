{ pkgs, ... }:

let
  gigalixir = pkgs.python39.pkgs.buildPythonPackage rec {
    pname = "gigalixir";
    version = "1.2.3";

    src = pkgs.python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-G3qa7X5ho4KPWhF3SAPtw5NY4qxGOzteUq8mfzQg3GY=";
    };

    doCheck = false;
  };
in
{
  home.packages = [ gigalixir ];
}
