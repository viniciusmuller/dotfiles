{ pkgs, ... }:

{
  documentation.man.generateCaches = true;
  documentation.dev.enable = true;

  # TODO: For some reason cannot get apropos to see development man pages
  # when the packages are inside home.nix, need to use it system-wide.
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
