function gsend --description "git add, git commit, git push"
    if test (count $argv) -lt 1
        echo "Usage: gacp <commit msg>"
        return 1
    end
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set_color red
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
    set msg (string join " " $argv)
    git add .
    git commit -m "$msg" >/dev/null; or begin
        set_color red
        echo "Falha no commit"
        set_color normal
        return 1
    end
    git push >/dev/null; or begin
        set_color red
        echo "Falha no push"
        set_color normal
        return 1
    end
    set_color green
    echo "🚀 Enviado"
    set_color normal
end
#Teste de commit