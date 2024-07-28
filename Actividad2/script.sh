#!/bin/bash

# Leer la variable GITHUB_USER
GITHUB_USER=$1

# Verificar si el parametro fue proporcionado
if [ -z "$GITHUB_USER" ]; then
	echo "ERROR101: Aun no ha proporcionado un nombre de usuario"
	exit 1
fi

# Consultar la url y concatenar la variable GITHUB_USER
response=$(curl -s https://api.github.com/users/${GITHUB_USER})

# User ID
user_id=$(echo $response | jq -r '.id')
if [ "$user_id" == "null" ];then
	echo "ERROR102: Usuario no encontrado"
	exit 1
fi

# Fecha de creacion de la cuenta extraida del JSON
created_at=$(echo $response | jq -r ".created_at")

# Imprimir mensaje 
message="Hola ${GITHUB_USER}. User ID: ${user_id}. Cuenta fue creada el: ${created_at}."
echo $message

# Crear log file  con la informacion del mensaje  obtenida anteriormente
log_dir="/tmp/$(date +%d-%m-%Y)"
mkdir $log_dir
log_file="${log_dir}/saludos.log"
echo $message >> $log_file

# Crear cronjob para que el script se ejecute cada 5 minutos
(crontab -l 2>/dev/null; echo "*/1 * * * * /ruta/al/script.sh $GITHUB_USER >> /tmp/cronjob_output.log 2>&1") | crontab -
