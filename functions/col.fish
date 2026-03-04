function col --description "Imprime coluna especifica"
    if test (count $argv) -ne 1
        echo "Uso: <cmd> | col <n>"
        return 1
    end
    awk "{print \$$argv[1]}"
end