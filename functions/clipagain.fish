function clipagain --description "Executa novamente o último comando do histórico e copia sua saída para a área de transferência"   # encontra o último comando que não seja clipagain
	set last ""
	for cmd in (history)
		if test "$cmd" != "clipagain"
			set last $cmd
			break
		end
	end
	if test -z "$last"
		echo "Nenhum comando válido encontrado no histórico."
		return 1
	end
	set prompt_line "($(whoami)@$(hostname)) $(pwd) \$ $last"
	set tmpfile (mktemp)
	eval $last 2>&1 | tee $tmpfile
	if type -q xclip
		begin; echo $prompt_line; cat $tmpfile; end | xclip -selection clipboard
	else if type -q xsel
		begin; echo $prompt_line; cat $tmpfile; end | xsel --clipboard --input
	else if type -q wl-copy
		begin; echo $prompt_line; cat $tmpfile; end | wl-copy
	else if type -q pbcopy
		begin; echo $prompt_line; cat $tmpfile; end | pbcopy
	else
		echo "⚠️ Nenhuma ferramenta de clipboard encontrada"
		rm $tmpfile
		return 1
	end
	rm $tmpfile
	set_color purple
	echo "Saída do último comando copiada para a área de transferência."
	set_color normal
end
