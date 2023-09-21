#Penúltima version de alpine

FROM alpine:3.17

#Al instalar wordpress en /var/www/wordpress señalamos /var/www como carpeta raiz
#para ejecutar comandos
WORKDIR /var/www

#Apk es el apt de alpine
#Instalamos php 8.2 y hph-fmp y todos los paquetes como dice la guia de instalación
#php-fpm es el gestor de procesos de FastCGI que conecta peticiones recibidas del nginx
#instalamos wget y tar para descargar el cliente de wordpress y extraerlo borrando el archivo comprimido y las configuraciones por defecto
#descargo el plugin de redis cache y lo movemos a la carpeta adecuada
#por seguridad generaro un usuario para el servidor de wordpress y le hacemos dueño de los archivos
#no tendra acceso a una shell (-s /bin/false)
RUN apk update && apk upgrade && apk add --no-cache php81 \
	php81-fpm \
	php81-mysqli \
	php81-curl \
	php81-exif \
	php81-mbstring \
	php81-openssl \
	php81-zip \
	wget \
	tar \
	&& adduser -s /bin/false -D wordpress_user \
	&& wget http://wordpress.org/latest.tar.gz \
	&& wget https://downloads.wordpress.org/plugin/redis-cache.2.4.1.zip \
	&& tar -xzvf latest.tar.gz \
	&& unzip redis-cache.2.4.1.zip \
	&& rm latest.tar.gz wordpress/wp-config-sample.php /etc/php81/php-fpm.d/www.conf redis-cache.2.4.1.zip \
	&& chown -R wordpress_user:wordpress_user redis-cache wordpress\
	&& cp redis-cache/includes/object-cache.php /var/www/wordpress/wp-content/ \
	&& mv redis-cache /var/www/wordpress/wp-content/plugins

#Php-fpm genera una conf base, por seguridad utilizo pools de php independientes de modo que cada aplicación
#se encuentre aislada y no pueda interferir con otros archivos
#en lugar de modificar el conf base generamos uno nuevo y lo añadimos a la carpeta (/etc/php81/php-fpm.d) para generar el pool
#tambien añado el conf de wordpress a la carpeta y con los permisos correspondientes
COPY --chmod=644 ./conf/wordpress_site.conf /etc/php81/php-fpm.d

COPY --chown=wordpress_user:wordpress_user --chmod=644 ./conf/wp-config.php /var/www/wordpress

#Ejecuto php-fpm con con flag -F para evitar que se ejecute como daemon(segundo plano) para que se mantenga en principal y primer plano
ENTRYPOINT ["/usr/sbin/php-fpm81", "-F"]
