function subl --description "Abre arquivos no Sublime, convertendo caminhos WSL automaticamente"
    set args

    for arg in $argv
        if test -e $arg
            set args $args (wslpath -w $arg)
        else
            set args $args $arg
        end
    end
    /mnt/c/Program\ Files/Sublime\ Text/subl.exe $args
end