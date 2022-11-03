registrarMatricula(){
    #si el usuario entra a esta opcion sin permisos de escritura se debe notificar que la operación no será guardada
    echo "Ingrese la matricula (SXX-####)"
    read matricula
    if [[ "$matricula" =~ ^[S]{1}[A-Z]{2}(-)[0-9]{4}$ ]]; then
        echo "Matricula Válida"
        echo "Ingrese la cédula del responsable (#.###.###-#)"
        read cedula
        if [[ "$cedula" =~ ^[0-9]{1}(.)[0-9]{3}(.)[0-9]{3}(-)[0-9]{1}$ ]]; then
            echo "La cedula es válida"
            echo "Ingrese fecha de vencimiento (YYYY-MM-DD)"
            read fechaVenc
            if [[ "$fechaVenc" =~ ^[2]{1}[0]{1}[0-9]{2}(-)[0-9]{2}(-)[0-3]{1}[0-9]$ ]]; then
                echo "$matricula|$cedula|$fechaVenc" >> matriculas.txt
                echo "Operacion exitosa"
            else   
                echo "fecha inválida"
            fi

        else
            echo "Cedula inválida"
            exit
        fi
    else
        echo "La matricula no es válida"
        exit
    fi
    menuInicio
}





verMatriculasRegistradas(){
    
    today=$(date '+%Y-%m-%d')
    probando=$(date -d '20210813' +'%Y-%m-%d')
    if [[ -f matriculas.txt ]]; then
        while IFS= read -r line; do
            matricula=$(echo $line | cut -d"|" -f1)
            cedula=$(echo $line | cut -d"|" -f2)
            fechaVenc=$(echo $line | cut -d"|" -f3)
            echo "$probando"
            if [[ "$fechaVenc" -le "$today" ]]; then     #falta terminar la comparacion de fechas que no funciona
                echo "$matricula | $cedula | vencido"
            else
                echo "$matricula | $cedula | en orden"

            fi
        done < matriculas.txt
    else
        echo "No hay matriculas registradas"
    fi
    #cat matriculas.txt
}


buscarMatriculasPorUsuario(){
    echo "Ingrese cédula a buscar"
    read cedula
    contador=0
    #buscar cedula en matriculas.txt y devolver la matricula asociada
    if [[ -f matriculas.txt ]]; then
        while IFS= read -r line; do
            matricula=$(echo $line | cut -d "|" -f1)
            ced=$(echo $line | cut -d "|" -f2)
            if [[ "$cedula" == "$ced" ]]; then
                echo "$matricula"
                contador=$((contador+1))
            fi
        done < matriculas.txt
    fi
    echo "Hay $contador matriculas asociadas al usuario"
    

    #funciones con parámetros https://linuxcenter.es/component/k2/item/65-parametros-en-shell-scripts-y-funciones 
}

cambiarPermisoModificacion(){
    #cambiar los permisos del archivo matriculas.txt de solo lectura a lectura y escritura, o viceversa según corresponda. 
    #Se debe pedir permiso sudo desde el script de bash y no previo a su ejecución.
    
    echo "1) Bloquear modificaciones"
    echo "2) Permitir modificaciones"
    read opcion
    if [ $opcion = 1 ]; then
        #bloquear modificaciones
        echo "Ingrese constraseña de admin"
        read pswd
        #modifica el permiso
        #sudo chmod 444 matriculas.txt
        echo "Modificación realizada correctamente"
        #se debe guardar en el log "“Se cambió permiso de modificación a ..."

    elif [ $opcion = 2 ]; then
        #permitir modificaciones
        echo "Ingrese constraseña de admin"
        read pswd
        #modifica el permiso
        #sudo chmod 666 matriculas.txt
        echo "Modificación realizada correctamente"
        #se debe guardar en el log "“Se cambió permiso de modificación a ..."

    else
        echo "No es una opción válida"
    fi

}

menuInicio(){
    opcion=1
    while [ $opcion != 5 ]; do
        echo "Seguros ConductORT"

        echo "1) Registrar Matricula"
        echo "2) Ver Matriculas Registradas"
        echo "3) Buscar Matriculas por Usuario"
        echo "4) Cambiar Permiso de Modificacion"
        echo "5) Salir"

        read opcion
        if [ $opcion = 1 ]; then
            registrarMatricula
        elif [ $opcion = 2 ]; then
            verMatriculasRegistradas
        elif [ $opcion = 3 ]; then 
            buscarMatriculasPorUsuario
        elif [ $opcion = 4 ]; then
            cambiarPermisoModificacion
        elif [ $opcion = 5 ]; then
            echo "Saliendo..."
            exit
        else
            echo "No es una opcion no valida"
        fi
    done
    echo "Saliendo..."
}

menuInicio