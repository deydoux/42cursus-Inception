#!/bin/sh

curl -o index.php https://www.adminer.org/latest-mysql.php
exec $@
