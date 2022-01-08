{ ... }:

{
  programs.mpv = {
    bindings = {
      "Shift+Alt++" = "add video-zoom  0.1              # zoom in";
      "Shift+Alt+-" = "add video-zoom -0.1              # zoom out";
      "Shift+Alt+0" = "set current-window-scale 0.5     # halve the window size";
      "Shift+Alt+1" = "set current-window-scale 1.0     # reset the window size";
      "Shift+Alt+2" = "set current-window-scale 2.0     # double the window size";
      "Alt+s" = "screenshot each-frame            # automatically screenshot every frame; issue this command again to stop taking screenshots";
    };
  };
}
