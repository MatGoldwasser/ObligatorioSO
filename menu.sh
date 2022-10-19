#!/bin/bash
menuInicio(){
    echo "1) Registrar Matricula"
    echo "2) Ver Matriculas Registradas"
    echo "3) Buscar Matriculas por Usuario"
    echo "4) Cambiar Permiso de Modificacion"
    echo "5) Salir"

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

ValidarMatricula(){
  
    if [ $1 = "ABC-123" ]; then
        echo "Matricula valida"
    else
        echo "Matricula invalida"
    fi
}
    if [ $matricula = "ABC123" ]; then
        echo "Matricula valida"
    else
        echo "Matricula invalida"
    fi
}

RegistrarMatricula(){
    echo "Ingrese la matricula"
    read matricula
    if [[ ValidarMatricula 'matricula' ]]; then
        echo "La matricula es valida"
    else
        echo "La matricula no es valida"
    fi

}
