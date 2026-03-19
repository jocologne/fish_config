function __twoline_prompt --description "Custom prompt"
    set -l last_status $status
    set -l cwd (prompt_pwd)
    set -l branch (git branch --show-current 2>/dev/null)
    set -l ts (date +"%H:%M:%S")

    # prefixo dependendo do usuário
    set -l left_plain ""
    if test (id -u) -eq 0
        set left_plain "🔴 "
    else if sudo -n true 2>/dev/null
        set left_plain "🔓 "
    end
    set left_plain "$left_plain$cwd"
    if test -n "$branch"
        set left_plain "$left_plain ($branch)"
    end

    # calcula espaço para alinhar relógio
    set -l pad (math $COLUMNS - (string length $left_plain) - (string length $ts) - 2)
    if test $pad -lt 1
        set pad 1
    end

    # linha 1: caminho + branch + relógio
    if test (id -u) -eq 0
        echo -n '🔴 '
    else if sudo -n true 2>/dev/null
        echo -n '🔓 '
    end
    set_color cyan
    echo -n $cwd
    if test -n "$branch"
        set_color magenta
        echo -n " ($branch)"
    end
    set_color normal
    printf "%*s" $pad ""
    set_color yellow
    echo $ts

    # linha 2: prompt com status
    if test $last_status -eq 0
        set_color green
        echo -n "❯❯❯ "
    else
        set_color red
        echo -n "❯❯❯ [$last_status] "
    end
    set_color normal
end
