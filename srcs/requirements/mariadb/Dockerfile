#Penúltima version de alpine

FROM alpine:3.17

#Variable utilizada para la build de la imagen, definida en el docker-compose y en el .env

ARG MADB_ROOT_PASSW MADB_USER MADB_PASSW WP_DB_NAME

#Instalo MariaDB y el cliente, por un bug la carpeta donde se genera el socket para realizar la conexión no se crea en la instalación
#por tanto la modifico a una que si se crea en la configuración de MariaDB

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

#En vez de modificar el archivo de conf añadimos nuestros archivos a la carpeta /etc/my.cnf.d/ , donde el servidor
#buscara los archivos de configuración terminados en .cnf
#Además copio el archivo .sql que lo utilizaremos para que el servidor ejecute comandos iniciales de sql
#Utilizo chown para crearlos con los permisos adecuados, siendo el dueño el usuari ode mysql y su grupo (los que se utilizan al inciar)
#Utilizo chmod para que no se pueda modificar por cualquier usuario y que mysql no permite archivos de configuración libres

COPY --chown=mysql:mysql --chmod=644 ./conf/mysqld.cnf ./conf/initfile.sql /etc/my.cnf.d/

#Realizamos el proceso de instalacion de instalacion de mysql, añadiendo los archivos de configuración a la carpeta correcta
#Utilizo el comando sed para expandir las variables ya que .sql no lo hace

RUN mysql_install_db \
    && sed -i "s/\$MADB_ROOT_PASSW/$MADB_ROOT_PASSW/g" /etc/my.cnf.d/initfile.sql \
    && sed -i "s/\$MADB_USER/$MADB_USER/g" /etc/my.cnf.d/initfile.sql \
    && sed -i "s/\$MADB_PASSW/$MADB_PASSW/g" /etc/my.cnf.d/initfile.sql \
    && sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /etc/my.cnf.d/initfile.sql

#Ejecuto el servidor, se ejecutara con la configuración anterior pero sin montarse

ENTRYPOINT ["mysqld"]
