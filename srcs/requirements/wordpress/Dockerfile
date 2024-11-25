ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache \
curl \
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

RUN curl -o /usr/local/bin/wp "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
RUN chmod +x /usr/local/bin/wp

COPY php-fpm.conf /etc/php82

WORKDIR /var/www/wordpress

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm82"]
