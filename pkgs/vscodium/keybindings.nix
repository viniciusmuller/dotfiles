[
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
  # Quick open project files
  {
    "key" = "ctrl+e";
    "command" = "workbench.action.quickOpen";
  }
  # Search project files content
  {
    "key" = "ctrl+f";
    "command" = "workbench.view.search";
  }
]
