function funclist --description "Lista funções do usuário com descrições"
    for file in ~/.config/fish/functions/*.fish
        set name (basename $file .fish)

        set content (cat $file)

        if string match -q -r -- '--description "' $content
            set desc (string match -r -- '--description "([^"]+)"' $content \
                | string replace -r '.*--description "([^"]+)".*' '$1' \
                | head -n1)

            printf "%-20s %s\n" $name $desc
        else
            printf "%-20s\n" $name
        end
    end
end