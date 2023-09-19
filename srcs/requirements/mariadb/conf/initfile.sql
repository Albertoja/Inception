--

--Permite modificar el usuario que queramos, en este el root, mantengo la autentificación por dual socket y por contraseña
--Añado la contraseña, IF EXIST hace que si no existe el usuario(Con root imposible) el programa no falle si no de un aviso
--El resto de clausulas son para evitar errores
ALTER USER IF EXISTS 'root'@'localhost' IDENTIFIED VIA unix_socket OR mysql_native_password USING PASSWORD('$MADB_ROOT_PASSW');
--Elimino el usuario por defecto ya que no lo necesito
DROP USER IF EXISTS 'mysql'@'localhost';
--Genero la base de datos de Wordpress(Si no existe)
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;
--Creo un usuario para poder modificar esa base de datos con su contraseña
CREATE USER IF NOT EXISTS '$MADB_USER'@'%' IDENTIFIED BY '$MADB_PASSW';
--Damos permiso a ese usuario para rodas las entradas de esa base de datos
GRANT ALL ON $WP_DB_NAME.* to '$MADB_USER'@'%';
--Actualizo la tabla de privilegios(algunos de los comandos anteriores no lo dejan registrado hasta el reinicio del sistema)
FLUSH PRIVILEGES;
