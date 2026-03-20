function mkpy --description "Cria arquivo Python (.py), opcionalmente executável (-e) e com print (-p)"
	argparse 'e/exec' 'p/print' -- $argv; or return
	if test (count $argv) -ne 1
		echo "Usage: mkpy <file.py> [-e|--exec] [-p|--print]"
		return 1
	end
	set file $argv[1]
	if not string match -q "*.py" "$file"
		set file "$file.py"
	end
	if test -e "$file"
		echo "⚠️ Arquivo ja existe"
		return 1
	end
	if set -q _flag_e
		echo '#!/usr/bin/env python3' > "$file"
		echo '' >> "$file"
		chmod +x "$file"
	else
		touch "$file"
	end
	if set -q _flag_p
		echo 'print("OK!!!")' >> "$file"
	end
	echo "🐍 Criado: $file"
end
