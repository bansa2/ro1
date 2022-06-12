FROM ubuntu
RUN apt update 
RUN apt-get install apache2
ADD . /var/www/html/synt
CMD apachectl -D FOREGROUND

