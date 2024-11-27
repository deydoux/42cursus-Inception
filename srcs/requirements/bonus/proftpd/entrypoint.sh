#!/bin/sh

echo "root:$(cat /run/secrets/password_proftpd_root.txt)" | chpasswd
exec $@
