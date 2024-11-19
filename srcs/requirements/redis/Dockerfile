FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y redis

USER redis
WORKDIR /var/lib/redis

COPY healthcheck.sh /usr/bin
HEALTHCHECK --interval=30s --timeout=10s --start-period=1s --retries=3 CMD ["healthcheck.sh"]

CMD ["redis-server", "/run/secrets/redis.conf"]
