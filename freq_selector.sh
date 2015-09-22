#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#							#
#	Autor: 		Mariano Hernandez Garcia	#
#	Licencia: 	en tramite...			#
#	Fecha:		03/12/2014			#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# VARIABLES

# UID del usuario que lanzo el script
E_UID=`id -g`

# Numero de CPUs del sistema
NUM_CPUS=`ls /sys/devices/system/cpu/ | grep cpu | grep [0-9] | wc -l`

# Nombre de las CPUS
NOMB_CPUS=`ls /sys/devices/system/cpu/ | grep cpu | grep [0-9] | tr -t '\n' ' '`

# Cogemos las frecuencias disponibles de la cpu0
FRECUENCIAS_DISPONIBLES=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`

# Opciones del menu principal
OPCIONES="Salir Cambiar_frecuencia"



# PROGRAMA

# Si tenemos permisos de superusuario (root)
if [ ${E_UID} -eq "0" ]
then
	
echo "------ Selector frecuencia CPU ------"
echo "Numero de CPUs: ${NUM_CPUS} [ ${NOMB_CPUS}]" 

function menu() {
	select opcion in ${OPCIONES}
	do
		case ${opcion} in

		Salir)
			exit 0
		;;

		Cambiar_frecuencia)
			echo "Selecciona la frecuencia:"
			select opcion2 in ${FRECUENCIAS_DISPONIBLES}
			do
				# Para cada cpu...
				for ((i=0;i<${NUM_CPUS};i++))
				do
					echo "Cambiando frecuencia cpu${i} a ${opcion2}Hz"
					# Escribimos en el fichero corespondiente la maxima frecuencia escalable
					echo ${opcion2} > "/sys/devices/system/cpu/cpu${i}/cpufreq/scaling_max_freq"

				done

				echo "Hecho!"
				exit 0

			done
		;;

		*)
			echo "Opcion no valida"
		esac

		menu
	done

}

menu

else
	echo "Error, ejecuta el script como root"
fi



