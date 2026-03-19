function lin --description "Imprime linhas específicas ou ranges (ex: lin 2 5 8..12 20)"
    if test (count $argv) -eq 0
        echo "Uso: lin 1 5 8..12 20"
        return 1
    end

    set -l nums
    for arg in $argv
        if string match -q '*..*' $arg
            set -l parts (string split .. $arg)
            for n in (seq $parts[1] $parts[2])
                set -a nums $n
            end
        else
            set -a nums $arg
        end
    end

    set -l lines (string join "|" $nums)
    awk -v l="$lines" 'BEGIN{split(l,a,"|"); for(i in a) w[a[i]]=1} NR in w'
end