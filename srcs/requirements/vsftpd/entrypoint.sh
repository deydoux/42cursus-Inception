#!/bin/sh

echo "root:$(cat /run/secrets/password_vsftpd_root.txt)" | chpasswd
exec $@
