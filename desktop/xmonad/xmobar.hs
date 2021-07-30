Config { font = "xft:JetBrains Mono:pixelsize=11:antialias=true:hinting=true"
        , borderColor = "black"
        , border = TopB
        , bgColor = "black"
        , fgColor = "grey"
        , position = TopW L 100
        , commands = [ Run Weather "SBPA" ["-t","<tempC>°C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 18000
                        , Run Cpu ["-L","3","-H","50","--normal","lightgreen","--high","red"] 10
                        , Run Memory ["-t","Mem: <used>MB"] 10
                        , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                        , Run StdinReader
                        , Run DiskU [("/", "<used>/<size>")]
                          ["-L", "20", "-H", "50", "-m", "1", "-p", "3",
                          "--normal", "lightgreen", "--high", "red" ] 20
                        , Run Kbd [ ("us(intl)", "<fc=#5ffa8d>INTL</fc>")
                                  , ("us"      , "<fc=#5ffaea>US</fc>")
                          ]
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% } <fc=#ee9a00>%date%</fc>  { %kbd% | %cpu% | %memory% | Disk: %disku% | SBPA: %SBPA% "
        }
