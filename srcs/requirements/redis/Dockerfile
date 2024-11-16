ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache redis

USER redis
CMD ["redis-server", "/run/secrets/redis.conf"]
