#!/bin/sh

echo "root:$(cat /run/secrets/password_ftp_root.txt)" | chpasswd
exec $@
