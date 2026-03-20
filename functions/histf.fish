function histf --description "Seleciona comando do histórico (ajustado ao tamanho da janela)"
	set lines (tput lines)
	set limit (math $lines - 8)

	set cmd (history | head -n $limit | fzf --prompt="Histórico> " --height=$limit --reverse)
	if test -n "$cmd"
		echo "Executando: $cmd"
		eval $cmd
	else
		echo "Nenhum comando selecionado."
	end
end
