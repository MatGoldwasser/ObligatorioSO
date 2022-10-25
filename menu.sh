registrarMatricula(){
    #si el usuario entra a esta opcion sin permisos de escritura se debe notificar que la operación no será guardada
    echo "Ingrese la matricula"
    read matricula
    #https://es.stackoverflow.com/questions/255732/ayuda-con-expresion-regular-para-validar-matriculas-de-coche
    if [ $matricula = ^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]{3}-[0-9]{4} ]; then
        echo "La matricula es valida"
        echo "Ingrese la cédula del responsable"
        read cedula
        if [ValidarCedula 'cedula' ]; then
            echo "La cedula es valida"
            echo "Ingrese fecha de vencimiento (YYYY-MM-DD)"
            read fechaVenc
            echo "$matricula | $cedula | $fechaVenc" >>matriculas.txt
            echo "Operacion exitosa"

        else 
            echo "Cedula invalida"
            exit
        fi
    else
        echo "La matricula no es valida"
        exit
    fi
    menuInicio
}

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

}

menuInicio