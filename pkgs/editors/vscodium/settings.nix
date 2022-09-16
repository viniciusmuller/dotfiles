let
  # multiCursor =
  #   {
  #     "before" = [ "<c-n>" ];
  #     "after" = [ "g" "b" ];
  #   };
  # lineStart =
  #   {
  #     "before" = [ "L" ];
  #     "after" = [ "$" ];
  #   };
  # lineEnd =
  #   {
  #     "before" = [ "H" ];
  #     "after" = [ "^" ];
  #   };
  hover =
    {
      "before" = [ "K" ];
      "after" = [ "g" "h" ];
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
  closeSplit =
    {
      "before" = [ "<c-q>" ];
      "commands" = [
        "workbench.action.closeEditorsInGroup"
      ];
    };
  visualBlock =
    {
      "before" = [ "<c-b>" ];
      "after" = [ "<c-q>" ];
    };
in
{
  "editor.rulers" = [ 80 120 ];
  "editor.wordWrap" = "on";
  "editor.minimap.enabled" = true;
  "editor.tabSize" = 2;
  "editor.insertSpaces" = true;
  "editor.bracketPairColorization.enabled" = true;

  # "editor.formatOnSave" = true;
  "editor.suggest.localityBonus" = true;

  # ---- Files ----
  "files.trimTrailingWhitespace" = true;

  # ---- Window ----
  "window.titleBarStyle" = "custom";
  "window.zoomLevel" = -1;
  # Disable top menu alt holding
  "window.enableMenuBarMnemonics" = false;

  # ---- Font ----
  "editor.fontFamily" = "Jetbrains Mono";
  "editor.fontSize" = 15;
  "terminal.integrated.gpuAcceleration" = "off";
  "editor.fontLigatures" = true;

  # ---- Aesthetics/workbench ----
  "workbench.colorTheme" = "GitHub Dark";
  "workbench.iconTheme" = "material-icon-theme";
  "workbench.startupEditor" = "newUntitledFile";

  # ---- VsVim ----
  # TODO: Move this to vspacecode directory #
  "editor.cursorSurroundingLines" = 5;
  "editor.lineNumbers" = "relative";
  "vim.enableNeovim" = true;
  "vim.neovimPath" = "nvim";
  "vim.timeout" = 50;
  "vim.sneakUseIgnorecaseAndSmartcase" = true;

  "vim.normalModeKeyBindingsNonRecursive" = [
    visualBlock
  ];

  "vim.normalModeKeyBindings" = [
    closeSplit
    hover
  ] ++ switchSplits;
}
