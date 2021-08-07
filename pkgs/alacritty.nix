{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 9;
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "None";
      };
      bell.duration = 0;
      background_opacity = 1.0;
      mouse.hide_when_typing = true;
      cursor = {
        style = "Beam";
        unfocused_hollow = true;
      };
    };
  };
}
