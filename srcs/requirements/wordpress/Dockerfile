ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl php82-fpm php82-mysqli
RUN curl -o /root/wordpress_latest.tar.gz "https://wordpress.org/latest.tar.gz"

COPY conf/php-fpm.conf /etc/php82

RUN adduser -D -g www www

VOLUME ["/var/www"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm82"]
