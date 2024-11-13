#!/bin/sh

mariadb-install-db --datadir=/var/lib/mysql --skip-test-db
chown -R mysql:mysql /var/lib/mysql
exec su - mysql -s /bin/sh -c "$*"
