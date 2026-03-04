function __time_prompt --description "Custom prompt"
	set -l cwd (basename (prompt_pwd))
	set -l timestamp (date +"%H:%M:%S")
	set_color green
	echo -n "[$timestamp] "
	set_color cyan
	echo -n "$cwd"
	set_color red
	echo -n ">> "
end