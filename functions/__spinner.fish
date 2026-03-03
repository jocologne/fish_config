function __spinner --description "Spinner simples"
    set pid $argv[1]
    set msg $argv[2]
    set frames "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏"
    while kill -0 $pid >/dev/null 2>&1
        for f in $frames
            printf "\r%s %s" $f $msg
            sleep 0.1
        end
    end
    printf "\r"
end