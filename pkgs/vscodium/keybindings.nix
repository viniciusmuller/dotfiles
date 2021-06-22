let
  searchFilesContent = {
    "key" = "ctrl+f";
    "command" = "workbench.view.search";
  };
  searchProjectFiles = {
    "key" = "ctrl+e";
    "command" = "workbench.action.quickOpen";
  };
  inlineNextDiff = {
    "key" = "ctrl+g";
    "command" = "editor.action.dirtydiff.next";
    "when" = "editorTextFocus";
  };
  inlinePreviousDiff = {
    "key" = "shift+ctrl+g";
    "command" = "editor.action.dirtydiff.previous";
    "when" = "editorTextFocus";
  };
  closeInlinedDiff = {
    "key" = "escape";
    "command" = "closeDirtyDiff";
    "when" = "dirtyDiffVisible";
  };
in
[
  # TODO: Name these expressions using `let`
  # Cycle completions with <tab> and <s-tab>
  {
    "key" = "tab";
    "command" = "selectNextQuickFix";
    "when" = "editorFocus && quickFixWidgetVisible";
  }
  {
    "key" = "shift+tab";
    "command" = "selectPrevQuickFix";
    "when" = "editorFocus && quickFixWidgetVisible";
  }
  {
    "key" = "tab";
    "command" = "selectNextSuggestion";
    "when" = "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible";
  }
  {
    "key" = "shift+tab";
    "command" = "selectPrevSuggestion";
    "when" = "editorTextFocus && suggestWidgetMultipleSuggestions && suggestWidgetVisible";
  }
  searchProjectFiles
  searchFilesContent
  inlineNextDiff
  inlinePreviousDiff
  closeInlinedDiff
]
