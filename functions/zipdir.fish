function zipdir --description "Zipar pasta com todo conteudo"
    set name (basename (pwd))
    set parent (dirname (pwd))
    zip -r "$parent/$name.zip" . >/dev/null 2>&1; or begin
        set_color red
        echo "Falha ao compactar"
        set_color normal
        return 1
    end
    set_color green
    echo -n "📦 Criado: "
    set_color normal
    echo "../$name.zip"
end