function bak --description "Backup a file or directory with a timestamped name"
	if test (count $argv) -eq 0
		echo "💾 Uso: bak <arquivo_ou_pasta>"
		return 1
	end

	set -l source $argv[1]
	set -l dest (dirname $source)/BAK_(date +%Y-%m-%d)_(basename $source)

	if not test -e $source
		echo "❌ Erro: '$source' não encontrado."
		return 1
	end

	mkdir -p (dirname $dest)
	cp -r $source $dest
	echo "💾 Backup criado: $source -> $dest"
end