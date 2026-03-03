function timer --description "Mede tempo de execução"
	argparse 'n/runs=' -- $argv; or return
	if test (count $argv) -lt 1
		echo "Uso: timer [-n N] <cmd>"
		return 1
	end
	if set -q _flag_n
		set runs $_flag_n
	else
		set runs 1
	end
	set times
	for i in (seq $runs)
		set start (date +%s%N)
		$argv
		set last_status $status
		set end (date +%s%N)
		set duration_ns (math $end - $start)
		set times $times $duration_ns
	end
	set sorted (printf "%s\n" $times | sort -n)
	if test $runs -ge 3
		set trimmed (printf "%s\n" $sorted | tail -n +2 | head -n -1)
	else
		set trimmed $sorted
	end
	set total 0
	set count 0
	for t in $trimmed
		set total (math "$total + $t")
		set count (math "$count + 1")
	end
	set avg_ns (math "$total / $count")
	if test $avg_ns -lt 1000000
		set value (math "$avg_ns / 1000.0")
		set unit "µs"
	else if test $avg_ns -lt 1000000000
		set value (math "$avg_ns / 1000000.0")
		set unit "ms"
	else
		set value (math "$avg_ns / 1000000000.0")
		set unit "s"
	end
	set_color cyan
	printf "Tempo de execução: %.3f %s\n" $value $unit
	set_color normal
	return $last_status
end