registrarMatricula(){
    #si el usuario entra a esta opcion sin permisos de escritura se debe notificar que la operación no será guardada
    echo "Ingrese la matricula"
    read matricula
    echo "mat:$matricula"
    if [[ "$matricula" =~ ^[S]{1}[A-Z]{2}(-)[0-9]{4}$ ]]; then
        echo "Ingrese la cédula del responsable"
        read cedula
        if [[ "$cedula" =~ ^[0-9]{1}(.)[0-9]{3}(.)[0-9]{3}(-)[0-9]{1}$ ]]; then
            echo "La cedula es válida"
            echo "Ingrese fecha de vencimiento (YYYY-MM-DD)"
            read fechaVenc
            if [ "'date '+%Y-%m-%d' -d $fechaVen 2>/dev/null'" = "$fechaVen" ]; then
                echo "$matricula | $cedula | $fechaVenc" >> matriculas.txt
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

#[ "$fechaVen" =~ ^[2]{1}[0]{1}[0-9]{2}(-)((0)[1-9]|(1)[0-2])((0)[1-9]|[1-2][0-9]|3[0-1])$ ]

verMatriculasRegistradas(){
    #if [fechaVencimiento < fechaActual]
    fecha=shell> date + "%d-%m-%Y" #fecha actual (DD/MM/YYYY)
    cat matriculas.txt
}

cantMatriculas(){
    cant=0
    #Buscar la cedula del usuario en el archivo usando la cedula como $1 (parámetro 1)
    #Por cada vez que aparezca el usuario sumarle uno a cant
    #echo "<matricula asociada a la cedula>"
}

buscarMatriculasPorUsuario(){
    echo "Ingrese cédula a buscar"
    read cedula
    cant=$(cantMatriculas $cedula)
    echo "Hay $cant matriculas asociadas al usuario"
    #Guardar la cedula consultada en el log

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