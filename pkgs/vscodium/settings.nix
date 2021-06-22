let
  multiCursor =
    {
      "before" = [ "<c-n>" ];
      "after" = [ "g" "b" ];
    };
  lineStart =
    {
      "before" = [ "L" ];
      "after" = [ "$" ];
    };
  lineEnd =
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    };
  switchSplits = [
    {
      "before" = [ "<c-h>" ];
      "after" = [ "<c-w>" "h" ];
    }
    {
      "before" = [ "<c-j>" ];
      "after" = [ "<c-w>" "j" ];
    }
    {
      "before" = [ "<c-k>" ];
      "after" = [ "<c-w>" "k" ];
    }
    {
      "before" = [ "<c-l>" ];
      "after" = [ "<c-w>" "l" ];
    }
    {
      "before" = [ "<c-l>" ];
      "after" = [ "<c-w>" "l" ];
    }
  ];
in
{
  "editor.rulers" = [ 80 120 ];
  "editor.minimap.enabled" = false;
  "editor.tabSize" = 2;
  "editor.insertSpaces" = true;
  "editor.formatOnSave" = true;

  # ---- Files ----
  "files.trimTrailingWhitespace" = true;

  # ---- Window ----
  "window.titleBarStyle" = "custom";
  "window.zoomLevel" = -1;
  # Disable top menu alt holding
  "window.enableMenuBarMnemonics" = false;

  # ---- Font ----
  "editor.fontFamily" = "Jetbrains Mono";
  "editor.fontSize" = 14;
  "terminal.integrated.gpuAcceleration" = "off";
  "editor.fontLigatures" = true;

  # ---- Aesthetics/workbench ----
  "workbench.colorTheme" = "One Dark Pro";
  "workbench.iconTheme" = "material-icon-theme";


  "workbench.startupEditor" = "newUntitledFile";

  # ---- VsVim ----
  "editor.lineNumbers" = "relative";
  "editor.cursorSurroundingLines" = 5;

  "vim.normalModeKeyBindings" = [
    multiCursor
    lineStart
    lineEnd
  ] ++ switchSplits;

  "vim.visualModeKeyBindings" = [
    multiCursor
  ];
}
