FROM ubuntu
RUN apt update && apt upgrade -y
ADD . /var/www/html/synt

