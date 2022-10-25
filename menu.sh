#!/bin/bash
menuInicio(){
    echo "1) Registrar Matricula"
    echo "2) Ver Matriculas Registradas"
    echo "3) Buscar Matriculas por Usuario"
    echo "4) Cambiar Permiso de Modificacion"
    echo "5) Salir"

}

#ValidarMatricula(){
#    read mat
#    if [ $mat = "ABC-123" ]; then
#        echo "Matricula valida"
#    else
#        echo "Matricula invalida"
#
#    fi
    #if [ $matricula = "ABC123" ]; then
    #    echo "Matricula valida"
    #else
    #    echo "Matricula invalida"
    #fi
#}


RegistrarMatricula(){
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


echo "Seguros ConductORT"
menuInicio
read opcion
if [ $opcion = 1 ]; then
    RegistrarMatricula
elif [ $opcion = 2 ]; then
    VerMatriculasRegistradas
elif [ $opcion = 3 ]; then 
    BuscarMatriculasPorUsuario
elif [ $opcion = 4 ]; then
    CambiarPermisoDeModificacion
elif [ $opcion = 5 ]; then
    echo "Saliendo..."
    exit
else
    echo "No es una opcion no valida"
fi

