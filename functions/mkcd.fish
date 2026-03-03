function mkcd --description "Cria e entra em diretório, opcionalmente inicializa git (-g) e abre no VSCode (-c)"
    argparse 'g/git' 'c/code' -- $argv; or return
    if test (count $argv) -ne 1
        echo "Usage: mkcd <dir>"
        return 1
    end
    set dir $argv[1]
    if test -d "$dir"
        echo "ℹ️  Diretório já existe"
        return 1
    end
    mkdir -p -- "$dir"; or return
    cd -- "$dir"; or return
    #Flag git
    if set -q _flag_g
        if not test -d .git
            git init -b main 2>/dev/null
            echo "🔧 Git inicializado"
        end
    end
    #Flag code
    if set -q _flag_c
        if command -q code
            code .
            echo "💻 Open code"
        else
            echo "⚠️ Comando não encontrado"
        end
    end
    echo "📁 "(pwd)
end