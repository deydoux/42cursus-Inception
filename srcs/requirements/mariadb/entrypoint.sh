#!/bin/sh

mariadb-install-db --datadir=/var/lib/mysql --skip-test-db
chown -R mysql: /var/lib/mysql
exec $@
