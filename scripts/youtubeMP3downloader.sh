#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#							#
#	Autor: 		Mariano Hernandez Garcia	#
#	Licencia: 	en tramite...			#
#	Fecha:		03/12/2014			#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# VARIABLES
NOMBRE_APP="youtubeMP3downloader"
DEPENDENCIAS="requires (ffmpeg or avconv) and (ffprobe or avprobe)"

# ARGUMENTOS

URL=$1
CALIDAD=$2


# PROGRAMA

echo "------ $NOMBRE_APP ------"
echo "This script $DEPENDENCIAS"


if [ $# -eq "1" ]
then
	echo "Descargando video y convirtiendolo en mp3 MAXIMA CALIDAD..."
	youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 $URL

elif [ $# -eq "2" ]
then
        echo "Descargando video y convirtiendolo en mp3..."
        youtube-dl --extract-audio --audio-format mp3 --audio-quality $CALIDAD $URL


else
	echo "Use: ./$NOMBRE_APP [URL] [CALIDAD]{0->best..9->worst}"
        exit

fi




