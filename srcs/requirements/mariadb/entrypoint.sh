#!/bin/sh

mariadb-install-db --datadir=/var/lib/mysql --skip-test-db
chown -R mariadb:mariadb /var/lib/mysql
exec su - mariadb -s /bin/sh -c "$*"
