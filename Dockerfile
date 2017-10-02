FROM nginx:alpine

RUN apk update && \
    apk add gettext bash && \
    mkdir -pv /etc/template.d && \
    rm -fv /etc/nginx/conf.d/default.conf

COPY ./conf.d/*.tpl /etc/template.d/
COPY entrypoint.sh /entrypoint.sh
COPY ./conf.d/settings.inc /var/www/site-php/settings.inc
COPY ./conf.d/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["bash", "-c"]

CMD ["/entrypoint.sh"]
