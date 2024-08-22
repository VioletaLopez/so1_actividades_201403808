# Servicio systemd: saludo_fecha

Este servicio ejecuta un script que imprime un saludo y la fecha actual cada segundo.

## Instalación

1. Crear el script `saludo_fecha.sh` en `/usr/local/bin/` con el siguiente contenido:

    ```bash
    #!/bin/bash

    while true; do
        echo "Hola, la fecha y hora actual es: $(date)"
        sleep 1
    done
    ```

2. Darle permisos de ejecución:

    ```bash
    sudo chmod +x /usr/local/bin/saludo_fecha.sh
    ```

3. Crear el archivo de servicio systemd en `/etc/systemd/system/saludo_fecha.service` con el siguiente contenido:

    ```ini
    [Unit]
    Description=Servicio que imprime un saludo y la fecha actual

    [Service]
    ExecStart=/usr/local/bin/saludo_fecha.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

4. Habilitar el servicio para que se inicie con el sistema:

    ```bash
    sudo systemctl enable saludo_fecha.service
    ```

5. Iniciar el servicio:

    ```bash
    sudo systemctl start saludo_fecha.service
    ```

## Verificar logs del servicio

Para ver los logs del servicio:

```bash
sudo journalctl -u saludo_fecha.service
