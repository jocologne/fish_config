function bak
	set -l source $argv[1]
	set -l dest (dirname $source)/BAK_(date +%Y-%m-%d)_$(basename $source)
	
	if not test -e $source
		echo "Error: Source path does not exist"
		return 1
	end
	
	if not test -d (dirname $dest)
		mkdir -p (dirname $dest)
	end
	
	cp -r $source $dest
	echo "Backup completed: $source -> $dest"
end