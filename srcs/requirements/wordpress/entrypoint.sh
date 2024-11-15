#!/bin/sh

tar -xzf /root/wordpress_latest.tar.gz --strip-components=1 -C /var/www
exec $@
