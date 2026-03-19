function open --description "Abre uma pasta ou arquivo do WSL no Explorer do Windows"
	if test (count $argv) -ge 1
		set alvo $argv[1]
	else
		set alvo .
	end
	if not test -e $alvo
		echo "❌ Erro: $alvo não encontrado."
		return 1
	end
	set win_path (wslpath -w $alvo)
	echo "📂 Abrindo: $win_path"
	explorer.exe $win_path
end