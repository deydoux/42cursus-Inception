ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache curl fcgi php82-fpm php82-iconv php82-mysqli php82-phar

RUN curl -o /usr/local/bin/wp "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
RUN chmod +x /usr/local/bin/wp

COPY php-fpm.conf /etc/php82

RUN adduser -D -g www www

VOLUME ["/var/www"]
WORKDIR /var/www

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm82"]
