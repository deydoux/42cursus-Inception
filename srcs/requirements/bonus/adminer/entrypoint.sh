#!/bin/sh

if [ ! -f index.php ]; then
	curl -L -o index.php https://www.adminer.org/latest-mysql.php
fi
exec $@
