FROM nginx:alpine

COPY ./conf.d/settings.inc /var/www/site-php/settings.inc
COPY ./conf.d/nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
