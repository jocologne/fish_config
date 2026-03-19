function zipdir --description "Zipar pasta com todo conteudo"
    if test (count $argv) -ge 1
        set target $argv[1]
        set name (basename $target)
        set parent (dirname $target)
    else
        set target .
        set name (basename (pwd))
        set parent (dirname (pwd))
    end
    if not test -d $target
        set_color red
        echo "Erro: '$target' não é uma pasta."
        set_color normal
        return 1
    end
    set zipfile "$parent/$name.zip"
    if test -e $zipfile
        while true
            read -l -P "Arquivo já existe. Deseja sobrescrever? [Y/n] " resposta
            switch $resposta
                case Y y
                    break
                case N n
                    echo "Operação cancelada."
                    return 0
                case '*'
                    echo "Resposta inválida. Digite Y para sim ou n para não."
            end
        end
    end
    zip -r $zipfile $target >/dev/null 2>&1; or begin
        set_color red
        echo "Falha ao compactar"
        set_color normal
        return 1
    end
    set_color green
    echo -n "📦 Criado: "
    set_color normal
    echo $zipfile
end
