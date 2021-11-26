{pkgs, ...}:

{
  home.packages = with pkgs; [
    lutris
  ];

  # environment.systemPackages = with pkgs; [
  #   # support both 32- and 64-bit applications
  #   # wineWowPackages.stable

  #   # support 32-bit only
  #   # wine

  #   # support 64-bit only
  #   # (wine.override { wineBuild = "wine64"; })

  #   # wine-staging (version with experimental features)
  #   # wineWowPackages.staging

  #   # winetricks and other programs depending on wine need to use the same wine version
  #   # winetricks
  #   # (winetricks.override { wine = wineWowPackages.staging; })
  # ];
}
