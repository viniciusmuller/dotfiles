{ pkgs, ...}:

{
  home.packages = with pkgs; [
    wayst
  ];

  xdg.configFile."wayst/config".text = ''
    # '#' starts a line comment
    # Strings with spaces need double quotes (use \" for " and \\ for \).

    # Set a list of primary fonts (All available styles will be loaded)
    # You need to list EVERY font you want to use. for example:
    # "IBM Plex Sans Thai" for thai script, "Noto Sans Math" for math symbols.
    # font = [
        # You can set codepoint ranges to which a given font should be applied.
        # Here we define <min>..u+24ff and u+2580..<max> to exclude the unicode
        # box drawing block. Those characters will be loaded (if present) from
        # the following fonts in this list.
        # "mononoki:..u+24ff:u+2580..",
        # "sauce code pro nerd font",
        # Mixing ttf/otf with bitmap fonts is ok
        # You can set an offset to keep fonts smaller/larger than the global size.
        # "Terminus:-3"
    # ]

    # Or just use a single font
    # font = "IBM Plex Mono"

    # Set a list of 'symbol' fonts (Only the 'Regular' style will be loaded)
    # font-symbol = [
        # "Noto Sans Symbols",
        # "FontAwesome"
    # ]

    # Set a list of color bitmap fonts.
    # font-color = "Noto Color Emoji"

    # use Semibold as the Bold style
    style-bold = "Semibold"
    font-size = 12
    dpi = 96

    # Load one of the default colorschemes
    # colorscheme = "wayst"
    # Overwrite parts of the colorscheme
    # fg-color = "#c7eeff"
    # bg-color = "#000000ee"

    # unfocused-tint = "#00000022"

    visual-bell = none

    term = "xterm-256color"

    title = "Terminal"

    # Set the type of window decorations hint (depends on window manager support)
    decorations = minimal

    # You can format the window title using variables: sAppTitle, sVtTitle, bCommandIsRunning,
    # i32CommandTimeSec, sRunningCommand, i32Rows, i32Cols, i32Width, i32Height.
    # To interpolate a variable use '{variableName}'. Variables can be used to define simple conditionals
    # eg: '{?i32Width > 80:the window is wider than 80px}'
    # The default format string displays the reported command if its running longer than a second
    # title-format = "{sVtTitle}{?bCommandIsRunning && i32CommandTimeSec > 1: ({sRunningCommand})} - {sAppTitle}"
    # Other examples:
    # title-format = "{sAppTitle} - [{sVtTitle}]"                                         # Terminal - [zsh:~]
    # title-format = "{sVtTitle} [{i32Cols}x{i32Rows}]"                                   # zsh:~ [80x24]
    # title-format = "{sVtTitle}{?i32Cols != 80 || i32Rows != 24: [{i32Cols}x{i32Rows}]}" # zsh:~ [132x54]

    title-format = "{sVtTitle}" # <set by program>

    scrollback = 1000

    # key names are the same as xorg keysym names (case sensitive!)
    bind-key-debug=Ctrl+Shift+Return
    bind-key-enlarge=Ctrl+Shift+equal
    bind-key-shrink=Ctrl+Shift+minus
    bind-key-copy=Ctrl+Shift+y
    bind-key-paste=Ctrl+Shift+p
  '';
}
