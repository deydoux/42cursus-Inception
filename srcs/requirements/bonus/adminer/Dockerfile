ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl fcgi php82-fpm php82-mysqli php82-session

COPY php-fpm.conf /etc/php82

WORKDIR /var/www/adminer

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=3s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm82"]
