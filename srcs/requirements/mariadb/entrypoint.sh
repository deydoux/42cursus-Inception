#!/bin/sh

mariadb-install-db --datadir=/var/lib/mysql --skip-test-db
exec $@
