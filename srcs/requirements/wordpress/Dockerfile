ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION} AS download

RUN apk add --no-cache curl

RUN curl -O "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
RUN chmod +x wp-cli.phar


FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache \
fcgi \
php82-curl \
php82-dom \
php82-exif \
php82-fileinfo \
php82-fpm \
php82-gd \
php82-iconv \
php82-intl \
php82-mysqli \
php82-pecl-imagick \
php82-phar \
php82-tokenizer \
php82-zip

COPY php-fpm.conf /etc/php82

WORKDIR /var/www/wordpress

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm82"]

COPY --from=download wp-cli.phar /usr/local/bin/wp
