function setprompt --description "Troca de prompt"
	if not functions -q __prompt_original
		functions -c fish_prompt __prompt_original
	end
	set prompts "minimal" "timed" "reset"
	set height (math (count $prompts) + 4)
	if test (count $argv) -eq 0
		set choice (printf "%s\n" $prompts | fzf --prompt="Escolha um prompt: " --height=$height --border)
		if test -z "$choice"
			echo "Cancelado."
			return 0
		end
		set argv $choice
	end
	switch $argv[1]
		case minimal
			function fish_prompt
				__minimal_prompt
			end
		case timed
			function fish_prompt
				__time_prompt
			end
		case reset
			functions -e fish_prompt
			functions -c __prompt_original fish_prompt
		case '*'
			echo "Uso: setprompt [minimal|timed|reset]"
	end
end