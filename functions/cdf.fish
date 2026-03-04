function cdf --description "Entra em pasta com menu interativo"
	set height (math (count (ls -d */)) + 4)
	set choice (ls -d */ 2>/dev/null | fzf --prompt="Entrar em: " --height=$height --border)
	if test -z "$choice"
		echo "Cancelado."
		return 0
	end
	cd $choice
end