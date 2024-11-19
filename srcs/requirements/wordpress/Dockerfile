FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y \
	ca-certificates \
	curl \
	libfcgi-bin \
	php-curl \
	php-gd \
	php-imagick \
	php-intl \
	php-mbstring \
	php-mysql \
	php-xml \
	php-zip \
	php7.4-fpm

RUN curl -o /usr/local/bin/wp "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
RUN chmod +x /usr/local/bin/wp

COPY php-fpm.conf /etc/php/7.4/fpm

WORKDIR /var/www/wordpress

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm7.4"]
