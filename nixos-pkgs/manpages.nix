{ pkgs, ... }:

{
  documentation.man.generateCaches = true;
  documentation.dev.enable = true;

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
