function cdf --description "Entra em pasta com menu interativo"
    set dirs (find . -maxdepth 1 -mindepth 1 -type d -not -name ".*" | string replace "./" "" | sort)
    if test -z "$dirs[1]"
        echo "Nenhuma pasta encontrada em "(pwd)
        return 0
    end
    set max 15
    set height (math (count $dirs) + 4)
    if test $height -gt $max
        set height $max
    end
    set choice (printf "%s\n" $dirs | fzf --prompt="Entrar em: " --height=$height --border)
    if test -z "$choice"
        echo "Cancelado."
        return 0
    end
    cd $choice
end