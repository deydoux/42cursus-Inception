ARG ALPINE_VERSION=3.19
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache redis

VOLUME ["/var/lib/redis"]
WORKDIR /var/lib/redis

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=1s --retries=3 CMD ["healthcheck.sh"]

COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]

USER redis
CMD ["redis-server", "/run/secrets/redis.conf"]
