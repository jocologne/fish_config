function __twoline_prompt --description "Custom prompt"
	set -l last_status $status
	set -l cwd (prompt_pwd)
	set -l branch (git branch --show-current 2>/dev/null)
	#Linha de informações
	if test (id -u) -eq 0
		echo -n '🔴 '
	else if sudo -n true 2>/dev/null
		echo -n '🔓 '
	end
	set_color cyan
	echo -n "$cwd "
	if test -n "$branch"
		set_color magenta
		echo -n "($branch) "
	end
	echo ""
	#Linha de prompt
	if test $last_status -eq 0
		set_color green
		echo -n "❯❯❯ "
	else
		set_color red
		echo -n "❯❯❯ [$last_status] "
	end
	set_color normal
end