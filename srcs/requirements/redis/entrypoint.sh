#!/bin/sh

chown -R redis:redis .
exec $@
