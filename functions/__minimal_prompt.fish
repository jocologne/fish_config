function __minimal_prompt --description "Custom prompt"
	set -l cwd (basename (prompt_pwd))
	set_color green
	echo -n "$cwd "
	set_color cyan
	echo -n ">"
	set_color red
	echo -n "> "
	set normal
end