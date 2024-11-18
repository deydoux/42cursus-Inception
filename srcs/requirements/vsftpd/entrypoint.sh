#!/bin/sh

cd /etc/vsftpd
echo "root" > virtual_users.txt
cat /run/secrets/password_vsftp_root.txt >> virtual_users.txt
db_load -T -t hash -f virtual_users.txt virtual_users.db
chmod 600 virtual_users.txt virtual_users.db

exec $@
