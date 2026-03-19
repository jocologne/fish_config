function clip --description "Executa um comando e copia sua saída para a área de transferência."
    set prompt_line "($(whoami)@$(hostname)) $(pwd) \$ $argv"
    set tmpfile (mktemp)
    if test (count $argv) -gt 0
        eval $argv 2>&1 | tee $tmpfile
    else
        cat | tee $tmpfile
    end
    if type -q xclip
        begin; echo $prompt_line; cat $tmpfile; end | xclip -selection clipboard
    else if type -q xsel
        begin; echo $prompt_line; cat $tmpfile; end | xsel --clipboard --input
    else if type -q wl-copy
        begin; echo $prompt_line; cat $tmpfile; end | wl-copy
    else if type -q pbcopy
        begin; echo $prompt_line; cat $tmpfile; end | pbcopy
    else
        echo "⚠️  Nenhuma ferramenta de clipboard encontrada"
        rm $tmpfile
        return 1
    end
    rm $tmpfile
	set_color purple
    echo "Copiado para a área de transferência."
	set_color normal
end