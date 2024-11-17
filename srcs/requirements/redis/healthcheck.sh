#!/bin/sh

redis-cli --askpass ping < /run/secrets/password_redis.txt | grep PONG
