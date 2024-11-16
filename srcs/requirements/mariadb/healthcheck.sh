#!/bin/sh

mariadb -u healthcheck -e "SHOW STATUS;"
