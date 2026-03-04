function col --description "Imprime colunas específicas"
    if test (count $argv) -lt 1
        echo "Uso: <cmd> | col <n1> <n2> ..."
        return 1
    end
    set script "{print"
    for c in $argv
        set script "$script \$$c,"
    end
    set script (string replace -r ',$' '' $script)
    set script "$script}"

    awk $script
end