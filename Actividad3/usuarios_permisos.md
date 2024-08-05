# Usuarios, grupos y permisos en un sistema operativo Linux

| Nombre | Carné |
|-------|--------|
| Marilyn Violeta López Hernández     | 201403808      |
---

## Contenido
- [Parte 1: Gestión de Usuarios](#Parte1)
- [Parte 2: Gestión de Grupos](#Parte2)
- [Parte 3: Gestión de Permisos](#Parte3)
- [Reflexión](#Conclusion)

## <a name="Parte1"></a>Parte 1: Gestión de Usuarios
### 1. Creación de Usuarios
```bash
sudo useradd usuario1
sudo useradd usuario2
sudo useradd usuario3
```
### 2. Asignación de Contraseñas
```bash
sudo passwd usuario1
# Nueva contraseña: ********
# Vuelva a escribir la nueva contraseña: ********

sudo passwd usuario2
# Nueva contraseña: ********
# Vuelva a escribir la nueva contraseña: ********

sudo passwd usuario3
# Nueva contraseña: ********
# Vuelva a escribir la nueva contraseña: ********
```
### 3. Información de Usuarios
```bash
id usuario1
# uid=1001(usuario1) gid=1001(usuario1) grupos=1001(usuario1)
```

### 4. Eliminación de Usuarios
```bash
sudo userdel -r usuario3
```

## <a name="Parte2"></a>Parte 2: Gestión de Grupos
### 1. Creación de Grupos
```bash
sudo groupadd grupo1
sudo groupadd grupo2
```

### 2. Agregar Usuarios a Grupos
```bash
sudo usermod -aG grupo1 usuario1
sudo usermod -aG grupo2 usuario2
```

### 3. Verificar Membresía
```bash
groups usuario1
# usuario1 : usuario1 grupo1
groups usuario2
# usuario2 : usuario2 grupo2
```

### 4. Eliminar Grupo
```bash
sudo groupdel grupo2
```

## <a name="Parte3"></a>Parte 3: Gestión de Permisos
### 1. Creación de Archivos y Directorios
Como usuario1
```bash
# Crear archivo `archivo1.txt` y escribir algo en él
echo "Contenido del archivo 1" > ~/archivo1.txt

# Crear directorio `directorio1` y archivo `archivo2.txt` dentro
mkdir ~/directorio1
echo "Contenido del archivo 2" > ~/directorio1/archivo2.txt
```

### 2. Verificar Permisos
```bash
ls -l ~/archivo1.txt
# -rw-r--r-- 1 usuario1 usuario1 20 ago  4 00:00 archivo1.txt

ls -ld ~/directorio1
# drwxr-xr-x 2 usuario1 usuario1 4096 ago  4 00:00 directorio1
```

### 3. Modificar Permisos usando chmod con Modo Numérico
```bash
chmod 640 ~/archivo1.txt
Resultado esperado: -rw-r----- 1 usuario1 usuario1 20 ago 4 00:00 archivo1.txt
```

### 4. Modificar Permisos usando chmod con Modo Simbólico
```bash
chmod u+x ~/directorio1/archivo2.txt
Resultado esperado: -rwxr-xr-x 1 usuario1 usuario1 20 ago 4 00:00 archivo2.txt
```

### 5. Cambiar el Grupo Propietario
```bash
sudo chgrp grupo1 ~/directorio1/archivo2.txt
Resultado esperado: -rwxr-xr-x 1 usuario1 grupo1 20 ago 4 00:00 archivo2.txt
```
### 6. Configurar Permisos de Directorio
```bash
chmod 740 ~/directorio1
Resultado esperado: drwxr----x 2 usuario1 usuario1 4096 ago 4 00:00 directorio1
```

### 7. Comprobación de Acceso
```bash
# Cambiar a usuario2
su - usuario2

# Intentar acceder a archivo1.txt
cat /home/usuario1/archivo1.txt
# Permiso denegado

# Intentar acceder a directorio1/archivo2.txt
cat /home/usuario1/directorio1/archivo2.txt
# Permiso denegado (usuario2 no puede entrar en directorio1)
```

### 8. Verificación Final
```bash
ls -l ~/archivo1.txt
# -rw-r----- 1 usuario1 usuario1 20 ago  4 00:00 archivo1.txt

ls -ld ~/directorio1
# drwxr----x 2 usuario1 usuario1 4096 ago  4 00:00 directorio1

ls -l ~/directorio1/archivo2.txt
# -rwxr-xr-x 1 usuario1 grupo1 20 ago  4 00:00 archivo2.txt
```
## <a name="Conclusion"></a> Reflexión (Opcional)
### ¿Por qué es importante gestionar correctamente los usuarios y permisos en un sistema operativo?
Es crucial gestionar adecuadamente los usuarios y permisos para asegurar la protección de datos, la privacidad y la integridad del sistema. Un manejo adecuado evita accesos no autorizados y permite una administración eficiente de recursos y responsabilidades.

### ¿Qué otros comandos o técnicas conocen para gestionar permisos en Linux?
chown: Cambiar el propietario y grupo de archivos o directorios.
setfacl y getfacl: Administrar listas de control de acceso (ACL).
umask: Establecer permisos predeterminados para archivos y directorios creados por el usuario.
sudo: Ejecutar comandos con privilegios de superusuario.
