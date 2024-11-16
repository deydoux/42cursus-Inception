#!/bin/sh

if ! wp core is-installed; then
	wp core download
	wp config create --dbname=wordpress --dbuser=wordpress --dbhost=mariadb --prompt=dbpass < /run/secrets/password_db_wordpress.txt
	wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user=root --admin_email="root@example.com" --prompt=admin_password < /run/secrets/password_wordpress_root.txt
fi

chown -R www:www .

exec $@
