
<?php
/* Aunque se pude modificar el archivo de configuración de ejmplo, inlcuyo un propio archivo de configuración
   pero utilizando la configuración más basica, todas las variables(usuarios, contraseñas etc...) estaran en
   el archivo .env y por tanto utilizaremos getenv(), la cual devuelve el valor de una variable
   al pasar su nombre por string (importante que esten entre comillas)
*/

define( 'DB_NAME', getenv('WP_DB_NAME') ); //Defino el nombre de la base que se usará
define( 'DB_USER', getenv('MADB_USER') ); //El nombre de usuario de la base de datos(No debe ser root)
define( 'DB_PASSWORD', getenv('MADB_PASSW') ); //Contraseña de la base de datos
define( 'DB_HOST', 'mariadb:3306'); //Señalo el host donde estara la base de datos, al ser otro contenedor, añadimos mariadb y su puerto(archivo dns de hostnames)

define( 'DB_CHARSET', 'utf8' ); //Codificacion de carácteres común
define( 'DB_COLLATE', '' );

/* Contraseñas y SALTs, distinas contraseñas y sus respectivos 
   SALT(conjunto de bits aleatorios que se usan como una de las entradas en una función derivadora de claves)
   tienen una capa extra de seguridad.
   Utilizo un generador de claves aleatorias que da el propio wordpress, para añadir nuestras propias claves
   que pueden ser modificadas en el archivo de variables
*/
define( 'AUTH_KEY',         getenv('AUTH_KEY') );
define( 'SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY') );
define( 'LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY') );
define( 'NONCE_KEY',        getenv('NONCE_KEY') );
define( 'AUTH_SALT',        getenv('AUTH_SALT') );
define( 'SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT') );
define( 'LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT') );
define( 'NONCE_SALT',       getenv('NONCE_SALT') );

$table_prefix = 'wp_';

define( 'WP_DEBUG', false ); //Desactivo el modo depuración de Wordpress

// Absolute path to the WordPress directory

if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php'; //Archivo de opciones del wordpress
