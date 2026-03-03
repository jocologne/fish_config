function timer --description "Mede tempo de execução"
	if test (count $argv) -lt 1
		echo "Uso: timer <cmd>"
		return 1
	end
	set start (date +%s%N)
	$argv
	set end (date +%s%N)
	set duration_ns (math $end - $start)
	if test $duration_ns -lt 1000000
		set value (math "$duration_ns / 1000.0")
		set unit "µs"

	else if test $duration_ns -lt 1000000000
		set value (math "$duration_ns / 1000000.0")
		set unit "ms"

	else
		set value (math "$duration_ns / 1000000000.0")
		set unit "s"
	end
	set_color cyan
	printf "Tempo de execução: %.3f %s\n" $value $unit
	set_color normal
	return $cmd_status
end