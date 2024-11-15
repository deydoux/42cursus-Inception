#!/bin/sh

tar -xzf /root/wordpress_latest.tar.gz --strip-components=1 -C /var/www
chown -R www:www /var/www
exec $@
