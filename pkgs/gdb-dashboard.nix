{ pkgs, ... }:

let
  repo = "cyrus-and/gdb-dashboard";
  file = ".gdbinit";
  commit = "101cf69cc95f90956b6d9612a3468dac6422c87c";
  gdb-dashboard-gdbinit = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/${repo}/${commit}/${file}";
    sha256 = "sha256-RDmglTiW9plsnbPFk3iYOw5Wc/CwHeeMzH2qBOXVCJY=";
  };
in
{
  home.packages = with pkgs; [
    gdb
    python39Packages.pygments
  ];

  home.file = {
    ".gdbinit".source = gdb-dashboard-gdbinit;
  };
}
