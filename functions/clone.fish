function clone --description "Clona um repositorio de um usuario do github"
    if test (count $argv) -lt 1
        set_color red
        echo "Uso: clone <repo>     clone <user> <repo>"
        set_color normal
        return 1
    end
    if test (count $argv) -eq 1
        set user jocologne
        set repo $argv[1]
    else if test (count $argv) -eq 2
        set user $argv[1]
        set repo $argv[2]
    end
    set url "https://github.com/$user/$repo.git"
    git clone $url >/dev/null 2>&1 &
    set pid $last_pid
    __spinner $pid "Clonando..." cyan
    wait $pid
    if not test -d "$repo"
        set_color red
        echo "Falha no clone"
        set_color normal
        return 1
    end
    echo "📁 Repositório clonado com sucesso"
end