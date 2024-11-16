#!/bin/sh

if ! wp core is-installed; then
	wp core download
	wp config create --dbname=wordpress --dbuser=wordpress --dbpass="$(cat /run/secrets/password_db_wordpress.txt)" --dbhost=mariadb
	wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user=root --admin_password="$(cat /run/secrets/password_wordpress_root.txt)" --admin_email="root@$DOMAIN_NAME"
fi

chown -R www:www .

exec $@
