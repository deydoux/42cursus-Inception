ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl php83-fpm
RUN curl -o /root/wordpress_latest.tar.gz "https://wordpress.org/latest.tar.gz"

COPY php-fpm.conf /etc/php83

VOLUME ["/var/www"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm83", "-F"]
