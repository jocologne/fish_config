function __spinner --description "Spinner simples"
    if test (count $argv) -lt 2
        echo "Usage: __spinner <pid> <msg> [color]"
        return 1
    end
    set pid $argv[1]
    set msg $argv[2]
    set valid_colors red green yellow blue magenta cyan white brred brgreen bryellow normal
    if test (count $argv) -ge 3
        set color $argv[3]
    else
        set color normal
    end
    if not contains $color $valid_colors
        set color normal
    end
    set frames "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏"
    while kill -0 $pid >/dev/null 2>&1
        for f in $frames
            set_color $color
            printf "\r%s %s" $f $msg
            set_color normal
            sleep 0.1
        end
    end
    printf "\r"
end