{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Vertex";
    };
    theme = {
      name = "Vertex-Dark";
      package = pkgs.theme-vertex;
    };
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };
}
