function gsend --description "git add, commit e push silencioso"
    argparse 'l/list' -- $argv; or return
    if test (count $argv) -lt 1
        set_color --bold red
        echo "Usage: gsend <msg>"
        set_color normal
        return 1
    end
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set_color --bold red
        echo "Não é repositório git"
        set_color normal
        return 1
    end
    if test -z (git status --porcelain)
        set_color yellow
        echo "Nada para commit"
        set_color normal
        return 0
    end
    if set -q _flag_l
        set_color cyan
        echo "Arquivos:"
        git status --short
        set_color normal
    end
    set msg (string join " " $argv)
    git add . >/dev/null 2>&1
    git commit -m "$msg" >/dev/null 2>&1; or begin
        set_color --bold red
        echo "Falha no commit"
        set_color normal
        return 1
    end
    git push >/dev/null 2>&1 &
    set pid $last_pid
    __spinner $pid "Enviando..." cyan
    wait $pid; or begin
        set_color --bold red
        echo "Falha no push"
        set_color normal
        return 1
    end
    set_color green
    echo "🚀 Enviado"
    set_color normal
end
#test 1