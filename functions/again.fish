function again --description "Executa novamente o último comando do histórico que não seja 'again'"
    for cmd in (history)
        if test "$cmd" != "again"
            eval $cmd
            break
        end
    end
end
