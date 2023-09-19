#Penúltima version de alpine

FROM alpine:3.17 

#Variable utilizada para la build de la imagen, definida en el docker-compose y en el .env

ARG DOMAIN

#Uso apk(el apt de alpine), flag --no-cache para no guardar en el cache del contenedor de imagenes, instalamos nginx y openssl y generamos el certificado
#y lo genero dentro del contenedor para poder usar https

RUN apk update && apk upgrade && apk add --no-cache nginx openssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj "/CN=$DOMAIN_NAME/C=SP/L=MADRID" \
		-keyout /etc/ssl/private/$DOMAIN_NAME.key -out /etc/ssl/certs/$DOMAIN_NAME.crt

#El archivo de configuración de ngninx se encuentra en /etc/nginx, pero es mejor tenerlo guardado en /etc/nginx/http.d al utilizar alpine, lo escribo para
#que se añada automáticamente y modifico los permisos para solo modificrse con root

COPY --chmod=644 ./conf/nginx.conf /etc/nginx/http.d/

#Nginx no sustituye las variables de entorno de sus archivos .conf, utilizo sed para sustituir la variable $DOMAIN

RUN sed -i "s/\$DOMAIN/$DOMAIN/g" /etc/nginx/http.d/nginx.conf

#Utilizamos el protocolo HTTPS, por tanto el puerto será 443

EXPOSE 443

#Dentro del contenedor ejecutamos la función -g para utilizar "daemon off", ya que si estuviera en on no detectaria el proceso principal y se cerraria al instante

ENTRYPOINT ["nginx", "-g", "daemon off;"]

