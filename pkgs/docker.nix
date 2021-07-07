{ pkgs, ... }:

with pkgs;
{
  home.packages = [
    docker-compose
    lazydocker
    docker
  ];
}
