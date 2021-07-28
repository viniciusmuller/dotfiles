Config { font = "xft:JetBrains Mono:pixelsize=11:antialias=true:hinting=true"
        , borderColor = "black"
        , border = TopB
        , bgColor = "black"
        , fgColor = "grey"
        , position = TopW L 100
        , commands = [ Run Weather "SBPA" ["-t","<tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 18000
                        , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                        , Run Memory ["-t","Mem: <used>MB"] 10
                        , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                        , Run StdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% } { %cpu% | %memory% | <fc=#ee9a00>%date%</fc> | Temp: %SBPA% "
        }
