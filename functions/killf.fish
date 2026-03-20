function killf --description "Mata o processo escolhido em uma lista"
	argparse 'f/force' -- $argv
	set proc (ps -eo pid,comm --sort=-pid | fzf --prompt="Processos> " --height=20 --reverse)
	if test -n "$proc"
		set pid (echo $proc | awk '{print $1}')
		if set -q _flag_f
			echo "Matando processo $pid com SIGKILL..."
			kill -9 $pid
		else
			echo "Encerrando processo com SIGTERM..."
			kill $pid
		end
	else
		echo "Nenhum processo selecionado."
	end
end