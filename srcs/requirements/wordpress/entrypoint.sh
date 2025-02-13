#!/bin/sh

if ! wp core is-installed 2>/dev/null; then
	wp core download
	wp config create --dbname=wordpress --dbuser=wordpress --dbhost=mariadb --prompt=dbpass < /run/secrets/password_db_wordpress.txt
	wp core install --url="https://$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user=root --admin_email="root@example.com" --skip-email --prompt=admin_password < /run/secrets/password_wordpress_root.txt
	wp user create deydoux "deydoux@student.42lyon.fr" --prompt=user_pass < /run/secrets/password_wordpress_deydoux.txt
	wp theme install variations
	wp theme activate variations
	wp plugin install redis-cache
	wp config set WP_REDIS_HOST redis
	wp config set WP_REDIS_PASSWORD --prompt < /run/secrets/password_redis.txt
	wp plugin activate redis-cache
	wp redis enable
fi
chown -R nobody: .
exec $@
